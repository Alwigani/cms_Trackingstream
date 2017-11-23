#!/bin/bash

SRC_ID=9999
SOURCE_NAME=CMS
TABLE_CMS=SECURE
BASE_DIR=`dirname $0`
SCRIPT_NAME=`basename $0`

#----Function---
function logger(){
    MESSAGE=$1
    echo "`date +%Y-%m-%d\ %H:%M:%S` | ${MESSAGE}"
    echo "`date +%Y-%m-%d\ %H:%M:%S` | ${MESSAGE}" >> ${LOG_FILE}
}

function cleanExit(){
    EXIT_CODE=$1
    rm ${LOCK_FILE}
    exit ${EXIT_CODE}
}

function mkdirP(){
    DIR_NAME=$1
    if [ ! -d ${DIR_NAME} ]; then mkdir -p ${DIR_NAME}; fi
    cd ${BASE_DIR}
}

#==============
if [ "${BASE_DIR}" == "." ]
then
    echo "Please use fullpath, eg./your/path/$0"
    exit 1
fi

SRC_TYPE=$1
CURR_DATE=$2
MAX_FILE=$3
JOB_ID=$4

SRC_TYPE_LOWER=`echo "${SRC_TYPE}" | tr "[:upper:]" "[:lower:]"`
SOURCE_NAME_LOWER=`echo "${SOURCE_NAME}" | tr "[:upper:]" "[:lower:]"`

if [[ $SRC_TYPE_LOWER == "trackingstream" ]]; then
    SRC_TYPE_1=CP
    SRC_TYPE_2=SE
fi

SCRIPT_NAME="${SCRIPT_NAME}.${SOURCE_NAME}"

if [ -z ${CURR_DATE} ]; then
    CURR_DATE=`python -c "import datetime; tmpDate=datetime.date.today() - datetime.timedelta(0); print tmpDate.strftime('%Y%m%d')"`
elif [ ${#CURR_DATE} -ne 8 ]; then
    CURR_DATE=`python -c "import datetime; tmpDate=datetime.date.today() - datetime.timedelta(${CURR_DATE}); print tmpDate.strftime('%Y%m%d')"`
fi

#if [ -z ${MAX_THREAD} ]; then MAX_THREAD=1; fi
MAX_THREAD=1
if [ -z ${MAX_FILE} ]; then MAX_FILE=1; fi

. ${BASE_DIR}/mysql_con.cfg

if [ -z ${JOB_ID} ]; then JOB_ID=$(getUniqueID); fi

LOCK_FILE=${BASE_DIR}/${SCRIPT_NAME}_${CURR_DATE}_${SRC_TYPE}.lck

#check apakah proses sedang running atau tidak
pid=$$
if [ -f ${LOCK_FILE} ]
then
    existing_pid=`cat ${LOCK_FILE}`
    #-check existing pid
    isAlive=`ps -def | grep -v "grep" | awk '{print $2}' | grep "^${existing_pid}$" | wc -l`
    if [ $isAlive -ge 1 ]
    then
        echo "Process with pid $existing_pid still running"
        exit 1
    fi
    echo "No process found for pid $existing_pid, continue"
    rm ${LOCK_FILE}
fi

echo "$pid" > ${LOCK_FILE}

HADOOP_COMMAND_FS="hadoop fs"

BASE_LOG_DIR=/data/cms/higt_reflex/script/log
LOG_MON_DIR=${BASE_LOG_DIR}/WEBMON
LOG_DIR=${BASE_LOG_DIR}/LOG
CONF_DIR=${BASE_LOG_DIR}/CONF
HFS_INPUT_DIR=/data/in/${SOURCE_NAME_LOWER}/${SRC_TYPE_LOWER}/${CURR_DATE}

mkdirP ${LOG_MON_DIR}; mkdirP ${LOG_DIR}; mkdirP ${CONF_DIR};

find ${LOG_MON_DIR} -name '*.*' -daystart -mtime +1 | xargs -t rm > /dev/null 2>&1 &
find ${LOG_DIR} -name '*.*' -daystart -mtime +1 | xargs -t rm > /dev/null 2>&1 &
find ${CONF_DIR} -name '*.*' -daystart -mtime +1 | xargs -t rm > /dev/null 2>&1 &

SRC_LIST_FILE=${CONF_DIR}/${SCRIPT_NAME}_${CURR_DATE}_${SRC_TYPE_LOWER}.src.list
UPL_LIST_FILE=${CONF_DIR}/${SCRIPT_NAME}_${CURR_DATE}_${SRC_TYPE_LOWER}.upl.list
LOG_FILE=${LOG_DIR}/${SCRIPT_NAME}_${CURR_DATE}_${JOB_ID}.log; export LOG_FILE
COLLECTED_FILE_LIST=${CONF_DIR}/${SCRIPT_NAME}_Collected_${CURR_DATE}_${SRC_TYPE_LOWER}.list
SRC_ANOMALY_LIST_FILE=${CONF_DIR}/${SCRIPT_NAME}_${CURR_DATE}_${SRC_TYPE_LOWER}.src.anomaly.list

if [ -f ${COLLECTED_FILE_LIST} ]; then rm -f ${COLLECTED_FILE_LIST}; fi
touch ${SRC_ANOMALY_LIST_FILE}

SOURCE_DIR=/data/sftpuser/cms/

#-get collectedd files
${MYSQL_HOME} -h${MYSQL_HOST} -u${MYSQL_USER} -p${MYSQL_PASSWORD} -NB -e "SELECT CONCAT('${SOURCE_DIR}',FILENAME,'|',FILESIZE) FILENAME FROM TB_FILE_COLLECT_${TABLE_CMS} USE INDEX(SCP_ID) WHERE SOURCE_TYPE = '${SOURCE_NAME}' AND SCP_ID = '${SRC_TYPE}' AND FILEDATE = ${CURR_DATE} ORDER BY FILENAME" ${MYSQL_DB} > ${COLLECTED_FILE_LIST} 2>&1

CNT=`grep -c "Can't connect to MySQL server" ${COLLECTED_FILE_LIST}`
if [ ${CNT} -gt 0 ]; then 
    logger "Can't connect to MySQL server ${MYSQL_HOST}"
    cleanExit 1
fi

logger "Check source file ${CURR_DATE}_${SOURCE_NAME_LOWER}_${SRC_TYPE_LOWER}..."

grep -v "Warning" ${COLLECTED_FILE_LIST} | sort -u > ${COLLECTED_FILE_LIST}.sort
cat ${SRC_ANOMALY_LIST_FILE}|sort -t"|" -k1,1 > ${SRC_ANOMALY_LIST_FILE}.sort

if [ -f ${UPL_LIST_FILE} ]; then rm -f ${UPL_LIST_FILE}; fi
touch ${UPL_LIST_FILE}

if [ -f ${SRC_LIST_FILE}.sort ]; then
    comm -23 ${SRC_LIST_FILE}.sort ${COLLECTED_FILE_LIST}.sort > ${UPL_LIST_FILE}
    
    cat ${UPL_LIST_FILE}|sort -t"|" -k1,1 > ${UPL_LIST_FILE}.sort.join
    cat ${COLLECTED_FILE_LIST}.sort |sort -t"|" -k1,1 > ${COLLECTED_FILE_LIST}.sort.join
    join -t\| -j1 1 -j2 1 -e "0" -o 1.1,1.2,2.2 ${UPL_LIST_FILE}.sort.join ${COLLECTED_FILE_LIST}.sort.join -a1 |awk -F\| '{print $0"|"($2-$3)}' |awk -F\| '{if($4>0) print $1"|"$2}' > ${UPL_LIST_FILE}
    
    cat ${UPL_LIST_FILE}|sort -t"|" -k1,1 > ${UPL_LIST_FILE}.sort.join
    join -t\| -j1 1 -j2 1 -e "NA" -o 1.1,1.2,2.1 ${UPL_LIST_FILE}.sort.join ${SRC_ANOMALY_LIST_FILE}.sort -a1 |grep "NA$"|awk -F\| '{print $1"|"$2}' | head -${MAX_FILE} > ${UPL_LIST_FILE}
fi

if [ `cat ${UPL_LIST_FILE}|wc -l` -eq 0 ]; then

    if [ ! -d ${SOURCE_DIR} ]; then
        logger "Folder ${SOURCE_DIR} is not found."
        cleanExit 21
    fi
    
    #CONTROL_LIST_FILE=${SRC_LIST_FILE}.ctl
    cd ${SOURCE_DIR}; ls -l *${SRC_TYPE_1}*${CURR_DATE}* > ${SRC_LIST_FILE}.all
    ls -l *${SRC_TYPE_2}*${CURR_DATE}* >> ${SRC_LIST_FILE}.all
    if [ `cat ${SRC_LIST_FILE}.all|wc -l` -eq 0 ]; then
        logger "No more files to collect"
        cleanExit 21
    fi
    
    #{
    #control list file, in format: filename
    #cat ${SRC_LIST_FILE}.all |grep "${CURR_DATE}" |grep "control"|awk -v DIR=${SOURCE_DIR} '{print DIR$9}' |sort -u > ${CONTROL_LIST_FILE}
    #} &
        
    {
    #list file, in format: filename|filesize
    #cat ${SRC_LIST_FILE}.all |grep "${CURR_DATE}"|grep -v "control" |awk -v DIR=${SOURCE_DIR} '{print DIR$9"|"$5}' |sort -u > ${SRC_LIST_FILE}.tmp
    cat ${SRC_LIST_FILE}.all |grep "${CURR_DATE}"|grep -v "control" |awk -v DIR=${SOURCE_DIR} '{print DIR$9"|"$5}' |sort -u > ${SRC_LIST_FILE}
    } &

    wait
        
    #cat ${CONTROL_LIST_FILE}|sed "s/control_//g"|sort -t"|" -k1,1 > ${CONTROL_LIST_FILE}.sort.join
    #cat ${SRC_LIST_FILE}.tmp |sort -t"|" -k1,1 > ${SRC_LIST_FILE}.sort.join
    #join -t\| -j1 1 -j2 1 -o 2.1,2.2 ${CONTROL_LIST_FILE}.sort.join ${SRC_LIST_FILE}.sort.join > ${SRC_LIST_FILE}
        
    if [ `cat ${SRC_LIST_FILE}|wc -l` -eq 0 ]; then
        logger "No more files to collect"
        cleanExit 21
    fi
    
    logger "Check new source file ${CURR_DATE}_${SOURCE_NAME_LOWER}_${SRC_TYPE_LOWER}..."
    #get file list to upload
    sort -u ${SRC_LIST_FILE} > ${SRC_LIST_FILE}.sort
    comm -23 ${SRC_LIST_FILE}.sort ${COLLECTED_FILE_LIST}.sort > ${UPL_LIST_FILE}
    
    cat ${UPL_LIST_FILE}|sort -t"|" -k1,1 > ${UPL_LIST_FILE}.sort.join
    cat ${COLLECTED_FILE_LIST}.sort |sort -t"|" -k1,1 > ${COLLECTED_FILE_LIST}.sort.join
    join -t\| -j1 1 -j2 1 -e "0" -o 1.1,1.2,2.2 ${UPL_LIST_FILE}.sort.join ${COLLECTED_FILE_LIST}.sort.join -a1 |awk -F\| '{print $0"|"($2-$3)}' |awk -F\| '{if($4>=0) print $1"|"$2}' > ${UPL_LIST_FILE}
    
    join -t\| -j1 1 -j2 1 -e "NA" -o 1.1,1.2,2.1 ${UPL_LIST_FILE}.sort.join ${SRC_ANOMALY_LIST_FILE}.sort -a1 |grep "NA$"|awk -F\| '{print $1"|"$2}' | head -${MAX_FILE} > ${UPL_LIST_FILE}

    if [ `cat ${UPL_LIST_FILE}|wc -l` -eq 0 ]; then
        logger "No more files to collect"
        if [ `cat ${SRC_ANOMALY_LIST_FILE}.sort|wc -l` -gt 0 ]; then
            logger "Data anomaly is found. Please check in file ${SRC_ANOMALY_LIST_FILE}"
        fi
        cleanExit 2110
    fi
fi

logger "Upload file ${CURR_DATE}_${SOURCE_NAME_LOWER}_${SRC_TYPE_LOWER} to ${HFS_INPUT_DIR}..."
${HADOOP_COMMAND_FS} -mkdir -p ${HFS_INPUT_DIR}

#-conf information for variable MAX_LOOP
getMaxLoop
LOOP=1
ITERASI=1
ITR_LOOP=1
MAX_ROW=`cat ${UPL_LIST_FILE} |wc -l |awk '{print $1}'`
COLLECT_MON_FILE=${LOG_MON_DIR}/${SOURCE_NAME}-${SRC_TYPE}-${ITR_LOOP}-${CURR_DATE}_collection_${JOB_ID:0:14}.mon
UPLOAD_MON_FILE=${LOG_MON_DIR}/${SOURCE_NAME}-${SRC_TYPE}-${ITR_LOOP}-${CURR_DATE}_upload_${JOB_ID:0:14}.mon

for srcFile in `cat ${UPL_LIST_FILE}`; do
    let ITERASI=${ITERASI}+1
    START_TIME=`date +%Y%m%d%H%M%S`
    SOURCE_FILE=`echo "${srcFile}"|awk -F\| '{print $1}'`
    baseFileName=`basename ${SOURCE_FILE}`
    FILE_NAME=`basename ${SOURCE_FILE}`
    SOURCE_FILE_SIZE=`echo "${srcFile}"|awk -F\| '{print $2}'`
    #TOTAL_FILE_ROW=`cat ${SOURCE_FILE} |wc -l`
    TOTAL_ROW_IN_CONTROL_FILE=0

    if [ -f ${SOURCE_FILE} ]; then
        x=x #error handling
    else
        logger "Source file ${SOURCE_FILE} is not found"
        echo "${SOURCE_FILE}|NOTFOUND" >> ${SRC_ANOMALY_LIST_FILE}
        continue
    fi
    
    logger "[DEBUG]: ${HADOOP_COMMAND_FS} -put -f ${SOURCE_FILE} ${HFS_INPUT_DIR}/${FILE_NAME} 2> ${LOG_DIR}/${FILE_NAME}.upd"
    ${HADOOP_COMMAND_FS} -put -f ${SOURCE_FILE} ${HFS_INPUT_DIR}/${FILE_NAME} 2> ${LOG_DIR}/${FILE_NAME}.upd

    if [ `${HADOOP_COMMAND_FS} -ls ${HFS_INPUT_DIR}/${FILE_NAME} |awk '{print $5}'` -eq ${SOURCE_FILE_SIZE} ]; then
        x=x #error handling
    else
        logger "Upload file ${SOURCE_FILE} is failed"
        #rm -f ${LOG_DIR}/${FILE_NAME}*
        continue
    fi

    END_TIME=`date +%Y%m%d%H%M%S`

    #format collection log: StartTime|EndTime|FileName|FileDate|SizeFile|TotalRow|ServerSizeFile|ServerTotalRow|DataSource|IsMerge|ZipFileSize      
    echo "${START_TIME}|${END_TIME}|${baseFileName}|${CURR_DATE}|${SOURCE_FILE_SIZE}|${TOTAL_ROW_IN_CONTROL_FILE}|${SOURCE_FILE_SIZE}|${TOTAL_ROW_IN_CONTROL_FILE}|${SRC_ID}|N|0" >> ${COLLECT_MON_FILE}
  
    #format upload: StartTime|EndTime|FileName|FileDate|Size|Totalrow|sourceid|IsMerge
    echo "${START_TIME}|${END_TIME}|${baseFileName}|${CURR_DATE}|${SOURCE_FILE_SIZE}|${TOTAL_ROW_IN_CONTROL_FILE}|${SRC_ID}|N" >> ${UPLOAD_MON_FILE}
	
    echo "
    DELETE FROM TB_FILE_COLLECT_${TABLE_CMS} WHERE SCP_ID = '${SRC_TYPE}' AND FILEDATE = ${CURR_DATE} AND FILENAME = '${FILE_NAME}';
    DELETE FROM TB_FILE_TO_JOB_${TABLE_CMS} WHERE SCP_ID = '${SRC_TYPE}' AND FILEDATE = ${CURR_DATE} AND REAL_FILENAME = '${baseFileName}' AND TRANF_JOB_ID = '0';
    INSERT INTO TB_FILE_COLLECT_${TABLE_CMS} (FILENAME,FILESIZE,SCP_ID,FILEDATE,SOURCE_DIR,SOURCE_TYPE,COLL_JOB_ID) VALUES ('${FILE_NAME}',${SOURCE_FILE_SIZE},'${SRC_TYPE}',${CURR_DATE},'${HFS_INPUT_DIR}','${SOURCE_NAME}','${JOB_ID}');
    INSERT INTO TB_FILE_TO_JOB_${TABLE_CMS} (REAL_FILENAME,ORIGINAL_FILESIZE,SCP_ID,FILEDATE,SOURCE_DIR,SOURCE_TYPE,COLL_JOB_ID,TRANF_JOB_ID) VALUES ('${baseFileName}',${SOURCE_FILE_SIZE},'${SRC_TYPE}',${CURR_DATE},'${HFS_INPUT_DIR}','${SOURCE_NAME}','${JOB_ID}','0');
    " >> ${LOG_FILE}.ins
    if [ ${LOOP} -eq ${MAX_THREAD} ] || [ ${ITERASI} -eq ${MAX_ROW} ]; then
        if [ `grep "INSERT" ${LOG_FILE}.ins |wc -l` -gt 0 ]; then
            logger "Send file log web monitoring..."
            function SendFile(){
                FILE=$1
                #--> don't use space for last script SFTP (before and after EOF)
                /usr/bin/sftp apps@${WEBMON_HOST} <<EOF > ${FILE}.log 2>&1
                put ${FILE} ${WEBMON_LOG_DIR}/`basename ${FILE}`
                ls -l ${WEBMON_LOG_DIR}/`basename ${FILE}`
                bye
EOF

                if [ `cat ${FILE}.log | grep "\-rw" | awk '{print $(NF-4)}'` -eq `ls -l ${FILE} | awk '{print $5}'` ]; then
                    mv ${FILE} ${FILE}.sent
                    rm -f ${FILE}.log
                    logger "Send file ${FILE} is successfully."
                else
                    logger "Send file ${FILE} is failed."
                    continue
                fi
            }

            #-send file log web monitoring
            if [ -f ${COLLECT_MON_FILE} ]; then
                echo "SendFile ${COLLECT_MON_FILE}"
            fi

            if [ -f ${UPLOAD_MON_FILE} ]; then
                echo "SendFile ${UPLOAD_MON_FILE}"
            fi

            logger "Insert data to table control..."
            
            echo "COMMIT;" >> ${LOG_FILE}.ins
            
            for (( I=1;I<=${MAX_LOOP};I++ )); do 
                ${MYSQL_HOME} -h${MYSQL_HOST} -u${MYSQL_USER} -p${MYSQL_PASSWORD} ${MYSQL_DB} < ${LOG_FILE}.ins
                MYSQL_RETVAL=$?
                if [ ${MYSQL_RETVAL} -eq 0 ] && [ ${I} -le ${MAX_LOOP} ]; then
                    break
                fi
            done
            
            if [ ${MYSQL_RETVAL} -ne 0 ]; then
                logger "Insert into table is failed."                
                mv ${LOG_FILE}.ins ${LOG_FILE}.ins.error.${FILE_NAME}
                echo "START TRANSACTION;" > ${LOG_FILE}.ins
                continue
            else
                rm -f ${LOG_FILE}.ins
            fi
        else
            logger "Command INSERT in ${LOG_FILE}.ins is not found"
            continue
        fi
        
        LOOP=1
        ITR_LOOP=${ITERASI}
        COLLECT_MON_FILE=${LOG_MON_DIR}/${SOURCE_NAME}-${SRC_TYPE}-${ITR_LOOP}-${CURR_DATE}_collection_${JOB_ID:0:14}.mon
        UPLOAD_MON_FILE=${LOG_MON_DIR}/${SOURCE_NAME}-${SRC_TYPE}-${ITR_LOOP}-${CURR_DATE}_upload_${JOB_ID:0:14}.mon

        #if [ -f ${COLLECT_MON_FILE} ]; then rm -f ${COLLECT_MON_FILE}; fi
        #if [ -f ${UPLOAD_MON_FILE} ]; then rm -f ${UPLOAD_MON_FILE}; fi

        echo "START TRANSACTION;" > ${LOG_FILE}.ins 
        LOOP=0
    fi
    
    let LOOP=${LOOP}+1
done

logger "End Main Process."

#-release lock
cleanExit 0
