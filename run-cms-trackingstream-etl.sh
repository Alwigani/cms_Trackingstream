#!/bin/bash

SRC_ID=999
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

#==============
if [ "${BASE_DIR}" == "." ]
then
    echo "Please use fullpath, eg./your/path/$0"
    exit 1
fi

#-input information
#SCP_ID=S
SOURCE_TYPE=CMS
SCP_ID=$1
BACK_DATE=$2
MAX_FETCH=$3  
JOB_ID=$4

if [ -z ${BACK_DATE} ]; then 
    echo "Please give params"
    exit 1
fi

if [ ${#BACK_DATE} -ne 8 ]; then
    PERIODE=`python -c "import datetime; today=datetime.date.today()-datetime.timedelta(${BACK_DATE}); print today.strftime('%Y%m%d')"`
else
    PERIODE=${BACK_DATE} #in format YYYYMMDD
fi

if [ -z ${MAX_FETCH} ]; then
    LIMIT_DATA=""
elif echo ${MAX_FETCH} | egrep -q '^[0-9]+$'; then 
    LIMIT_DATA="LIMIT ${MAX_FETCH}"
else
    logger "Parameter MAX_FETCH is wrong. Process aborted."
    exit 4 
fi

. ${BASE_DIR}/mysql_con.cfg

if [ -z ${JOB_ID} ]; then JOB_ID=$(getUniqueID); fi
JOB_ID_LOWER=`echo "${JOB_ID}" | tr "[:upper:]" "[:lower:]"`

LOCK_FILE=${BASE_DIR}/${SCRIPT_NAME}_${PERIODE}.lck

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

. ~/.bash_profile
HADOOP_COMMAND_FS="hadoop fs"
HADOOP_COMMAND_JAR="hadoop jar"

BASE_LOG_DIR=/data/cms/hnat_reflex/script/log
LOG_DIR=${BASE_LOG_DIR}/log
HDP_LOG_DIR=${BASE_LOG_DIR}/hgrid_log
WEBMON_DIR=${BASE_LOG_DIR}/webmon
if [ ! -d ${BASE_LOG_DIR} ]; then mkdir -p ${BASE_LOG_DIR}; fi
if [ ! -d ${LOG_DIR} ]; then mkdir -p ${LOG_DIR}; fi
if [ ! -d ${HDP_LOG_DIR} ]; then mkdir -p ${HDP_LOG_DIR}; fi
if [ ! -d ${WEBMON_DIR} ]; then mkdir -p ${WEBMON_DIR}; fi

LOG_FILE=${LOG_DIR}/${SCRIPT_NAME}_${PERIODE}_${JOB_ID}.log; export LOG_FILE

JAR_FILE=${BASE_DIR}/Cms.jar
CLASS_NAME=Cms.Trackingstream_step1
CLASS_NAME_FINAL=Cms.Trackingstream_final
FILE_CONF=${BASE_DIR}/${CLASS_NAME}.conf
FILE_CONF_FINAL=${BASE_DIR}/${CLASS_NAME_FINAL}.conf

HDP_LOG_FILE=${HDP_LOG_DIR}/${CLASS_NAME}_${PERIODE}_${JOB_ID}.log
HDP_LOG_PROC_FILE=${LOG_DIR}/${CLASS_NAME}_${PERIODE}_${JOB_ID}.proc
HDP_LOG_PROC_FILE_FINAL=${LOG_DIR}/${CLASS_NAME_FINAL}_${PERIODE}_${JOB_ID}.proc

#-conf information
getMaxLoop
HFS_LIST_DIR=/data/out/cms/trackingstream/list
HFS_REJECT_DIR=/data/out/cms/trackingstream/rej/${PERIODE}/${JOB_ID_LOWER}
HFS_OUTPUT_CLEAN_DIR=/data/out/cms/trackingstream/ok/${PERIODE}
HFS_OUTPUT_FINAL_DIR=/data/out/cms/trackingstream/final/${PERIODE}

logger "Hadoop Process ${PERIODE} is Running ..."
HFS_INPUT_FILE=`${MYSQL_HOME} -h${MYSQL_HOST} -u${MYSQL_USER} -p${MYSQL_PASSWORD} -NB -e "SELECT CONCAT_WS('/',SOURCE_DIR,REAL_FILENAME) FROM TB_FILE_TO_JOB_SECURE USE INDEX (SCP_ID) WHERE FILEDATE = ${PERIODE} AND SOURCE_TYPE = '${SOURCE_TYPE}' AND SCP_ID = '${SCP_ID}' AND TRANF_JOB_ID IN ('0','1') LIMIT 1" ${MYSQL_DB}` 

if [ ! -z ${HFS_INPUT_FILE} ]; then
    for (( I=1;I<=${MAX_LOOP};I++ )); do
	${MYSQL_HOME} -h${MYSQL_HOST} -u${MYSQL_USER} -p${MYSQL_PASSWORD} -NB -e "SELECT CONCAT_WS('/',SOURCE_DIR,REAL_FILENAME) FILEPATH FROM TB_FILE_TO_JOB_SECURE USE INDEX (SCP_ID) WHERE FILEDATE = ${PERIODE} AND SOURCE_TYPE = '${SOURCE_TYPE}' AND SCP_ID = '${SCP_ID}' AND TRANF_JOB_ID IN ('0','1') ORDER BY REAL_FILENAME ${LIMIT_DATA}" ${MYSQL_DB} |grep -v  FILEPATH > ${LOG_DIR}/${SCRIPT_NAME}_${PERIODE}_${JOB_ID_LOWER}.list
    
	MYSQL_RETVAL=$?
        if [ ${MYSQL_RETVAL} -eq 0 ] && [ ${I} -le ${MAX_LOOP} ]; then
            break
        fi
    done
    
    if [ ${MYSQL_RETVAL} -ne 0 ]; then
        echo "Get list file failed" 
        cleanExit 1
    fi
fi

if [ `cat ${LOG_DIR}/${SCRIPT_NAME}_${PERIODE}_${JOB_ID_LOWER}.list |wc -l` -eq 0 ] ; then
    logger "List file ${PERIODE} is not found"
    cleanExit 1
fi

REAL_FILENAME_CEK=`cat ${LOG_DIR}/${SCRIPT_NAME}_${PERIODE}_${JOB_ID_LOWER}.list|tr '\n' ' '`
${HADOOP_COMMAND_FS} -ls ${REAL_FILENAME_CEK} | grep "/" | awk '{print $NF}' | ${HADOOP_COMMAND_FS} -put - ${HFS_LIST_DIR}/${SCRIPT_NAME}_${PERIODE}_${JOB_ID_LOWER}.list 

REAL_FILENAME_LIST=`${HADOOP_COMMAND_FS} -cat ${HFS_LIST_DIR}/${SCRIPT_NAME}_${PERIODE}_${JOB_ID_LOWER}.list|awk -F\/ '{print $NF}'|tr '\n' ','|sed "s/,/','/g"|sed "s/^/'/g"|sed "s/,'$//g"`

#-update JOB_ID
echo "UPDATE TB_FILE_TO_JOB_SECURE SET TRANF_JOB_ID = '1' WHERE FILEDATE = '${PERIODE}' AND SCP_ID = '${SCP_ID}' AND REAL_FILENAME IN (${REAL_FILENAME_LIST})" > ${LOG_FILE}.sql
for (( I=1;I<=${MAX_LOOP};I++ )); do 
   ${MYSQL_HOME} -h${MYSQL_HOST} -u${MYSQL_USER} -p${MYSQL_PASSWORD} ${MYSQL_DB} < ${LOG_FILE}.sql > ${LOG_FILE}.upd 2>&1
   if [ `grep -v "^Warning" ${LOG_FILE}.upd | wc -l` -eq 0 ] && [ ${I} -le ${MAX_LOOP} ]; then
       break
   fi
done
                                                                                       
#check if file is empty
if [ `grep -v "^Warning" ${LOG_FILE}.upd | wc -l` -gt 0 ]; then
    logger "Update table TB_FILE_TO_JOB_SECURE is failed. Log in ${LOG_FILE}.upd" 
    cleanExit 7
fi
rm -f ${LOG_FILE}.upd ${LOG_FILE}.sql
   
logger "Running Hadoop Jar ${CLASS_NAME}"
cd ${HDP_LOG_DIR}
if [ -f ${HDP_LOG_FILE} ]; then rm -f ${HDP_LOG_FILE}; fi
touch ${HDP_LOG_FILE}
cp ${FILE_CONF} ${HDP_LOG_DIR}/`basename ${FILE_CONF}`
    
logger "[DEBUG]: ${HADOOP_COMMAND_JAR} ${JAR_FILE} ${CLASS_NAME} \"?${HFS_LIST_DIR}/${SCRIPT_NAME}_${PERIODE}_${JOB_ID_LOWER}.list\" ${HFS_REJECT_DIR} ${HFS_OUTPUT_CLEAN_DIR} ${PERIODE} ${PERIODE}_${JOB_ID} > ${HDP_LOG_PROC_FILE} 2>&1"

${HADOOP_COMMAND_JAR} ${JAR_FILE} ${CLASS_NAME} "?${HFS_LIST_DIR}/${SCRIPT_NAME}_${PERIODE}_${JOB_ID_LOWER}.list" ${HFS_REJECT_DIR} ${HFS_OUTPUT_CLEAN_DIR} ${PERIODE} ${PERIODE}_${JOB_ID} > ${HDP_LOG_PROC_FILE} 2>&1
    
#-check for error workflow
IS_OK=`tail -10 ${HDP_LOG_PROC_FILE} | grep OK`
NOT_STOP=`grep "stopped all jobs" ${HDP_LOG_PROC_FILE}|wc -l`
#-if success than create config file for aggmonthly process
if [ "${IS_OK}" == "OK" ] && [ ${NOT_STOP} -eq 0 ]; then
    logger "Process Step1 is OK"
    {
    if [ `${HADOOP_COMMAND_FS} -ls ${HFS_REJECT_DIR}/hgrid*|head -1|wc -l` -eq 0 ]; then
        ${HADOOP_COMMAND_FS} -rm -r ${HFS_REJECT_DIR}
    fi
    } &
else
    ${HADOOP_COMMAND_FS} -rm -r ${HFS_REJECT_DIR}
    logger "Process Step1 is not OK"
    cleanExit 31
fi

logger "Process manage block size..."
TOTAL_COMPRESS_SIZE=`${HADOOP_COMMAND_FS} -ls ${HFS_OUTPUT_CLEAN_DIR}/hgrid*|awk '{x+=$5}END {print x}'`
function getReducer() {
    PARAM_REDUCER=$1
    #--536870912 = 512*1024*1024
    BLOCK_SIZE=536870912
    if [ ${TOTAL_COMPRESS_SIZE} -le ${BLOCK_SIZE} ]; then
        TOTAL_REDUCER=1
    else
        #--round up
        TOTAL_REDUCER=`python -c "a=(${TOTAL_COMPRESS_SIZE}+${TOTAL_COMPRESS_SIZE}*${PARAM_REDUCER}/100)/${BLOCK_SIZE}+1; print a"`
    fi
    export TOTAL_REDUCER PARAM_REDUCER
}
    
getReducer 70
TOTAL_REDUCER_OLD=${TOTAL_REDUCER}

while true; do
	logger "Process data ${PERIODE}..."
	logger "TOTAL_COMPRESS_SIZE=${TOTAL_COMPRESS_SIZE}"
	logger "TOTAL_REDUCER=${TOTAL_REDUCER}"
	
	mkdir -p ${HDP_LOG_DIR}/${JOB_ID_LOWER}
	cd ${HDP_LOG_DIR}/${JOB_ID_LOWER}
	
	#--update reducer
	cat ${FILE_CONF_FINAL} | sed "s/mapred.reduce.tasks,5/mapred.reduce.tasks,${TOTAL_REDUCER}/g" > ${HDP_LOG_DIR}/${JOB_ID_LOWER}/`basename ${FILE_CONF_FINAL}`
	
	logger "[DEBUG]: ${HADOOP_COMMAND_JAR} ${JAR_FILE} ${CLASS_NAME_FINAL} ${HFS_OUTPUT_CLEAN_DIR} ${HFS_OUTPUT_FINAL_DIR} ${PERIODE}_${JOB_ID} > ${HDP_LOG_PROC_FILE_FINAL} 2>&1"
	${HADOOP_COMMAND_JAR} ${JAR_FILE} ${CLASS_NAME_FINAL} ${HFS_OUTPUT_CLEAN_DIR} ${HFS_OUTPUT_FINAL_DIR} ${PERIODE}_${JOB_ID} > ${HDP_LOG_PROC_FILE_FINAL} 2>&1
	
	#-check for error workflow
	if [ `grep "^OK" ${HDP_LOG_PROC_FILE_FINAL}|wc -l` -gt 0 ] && [ `${HADOOP_COMMAND_FS} -ls ${HFS_OUTPUT_FINAL_DIR}/_SUCCESS|wc -l` -gt 0 ]; then
		#check size output di atas 512mega
		SIZE_MAX=0
		BLOCK_SIZE=536870912
		for SIZE in `${HADOOP_COMMAND_FS} -ls ${HFS_OUTPUT_FINAL_DIR}/h*|awk '{print $5}'`; do
			if [ ${SIZE} -gt ${BLOCK_SIZE} ]; then 
				SIZE_MAX=0
				break
			else
				SIZE_MAX=1
			fi
		done
		
		if [ ${SIZE_MAX} -eq 1 ]; then
			break
		else                
			logger "Block size output final is not ok. Get new Total Reducer..."
			TOTAL_COMPRESS_SIZE_FINAL=`${HADOOP_COMMAND_FS} -ls ${HFS_OUTPUT_FINAL_DIR}/hgrid*|awk '{x+=$5}END {print x}'`
			
			if [ ${TOTAL_COMPRESS_SIZE_FINAL} -gt ${TOTAL_COMPRESS_SIZE} ]; then
				let PARAM_REDUCER=${TOTAL_COMPRESS_SIZE_FINAL}/${TOTAL_COMPRESS_SIZE}*100
			else
				PARAM_REDUCER=`echo "scale=1;${TOTAL_COMPRESS_SIZE_FINAL}/${TOTAL_COMPRESS_SIZE}*100"|bc|awk -F'.' '{print $1}'`
			fi
			
			getReducer ${PARAM_REDUCER}
			
			if [ ${TOTAL_REDUCER} -eq ${TOTAL_REDUCER_OLD} ]; then
				let TOTAL_REDUCER=${TOTAL_REDUCER}+10
			else
				TOTAL_REDUCER_OLD=${TOTAL_REDUCER}
			fi
		fi
	else
		break
	fi
	
	if [ -f ${HDP_LOG_DIR}/${JOB_ID_LOWER}/`basename ${HDP_LOG_FILE}` ]; then
		mv ${HDP_LOG_DIR}/${JOB_ID_LOWER}/`basename ${HDP_LOG_FILE}` ${HDP_LOG_FILE}
	fi
	rm -rf ${HDP_LOG_DIR}/${JOB_ID_LOWER}
	cd ${HDP_LOG_DIR} #error handle: shell-init: error retrieving current directory: getcwd: cannot access parent directories: No such file or directory hadoop 
done

#--Check source file
${HADOOP_COMMAND_FS} -ls ${HFS_OUTPUT_FINAL_DIR} |head > ${LOG_FILE}.check
if [ `cat ${LOG_FILE}.check|grep "SUCCESS"|wc -l` -gt 0 ] && [ `cat ${LOG_FILE}.check|grep "hgrid"|wc -l` -gt 0 ] ;then
    rm ${LOG_FILE}.check
else
    rm ${LOG_FILE}.check
    logger "Source data ${HFS_OUTPUT_FINAL_DIR} is not found"
    cleanExit 21 
fi
#-- End Check source file

#--Loading data to impala
TABLE_NAME=STG_CMS_TRACKINGSTREAM 
IQL_SCRIPT_FILE=${LOG_DIR}/${SCRIPT_NAME}_${PERIODE}.iql

logger "Loading data ${HFS_OUTPUT_FINAL_DIR} to table..."

function execProc() {
    MSG=$1
    logger "${MSG}"    
    export HADOOP_CLIENT_OPTS="-Djline.terminal=jline.UnsupportedTerminal"
    
    LOG_PROCESS_FILE=${IQL_SCRIPT_FILE}.proc.log                                              
    echo "--execute ${MSG}-------------------"|sed "s/\.//g" >> ${LOG_PROCESS_FILE} 2>&1
    logger "[DEBUG] beeline -u 'jdbc:hive2://virapapp1.telkomsel.co.id:10000/default;principal=hive/virapapp1@TELKOMSEL.CO.ID' < ${IQL_SCRIPT_FILE} > ${LOG_PROCESS_FILE} 2>&1" 
    beeline -u 'jdbc:hive2://virapapp1.telkomsel.co.id:10000/default;principal=hive/virapapp1@TELKOMSEL.CO.ID' < ${IQL_SCRIPT_FILE} > ${LOG_PROCESS_FILE} 2>&1
    RETVAL=`echo $?`
    FAILED=`grep "FAILED" ${LOG_PROCESS_FILE}|grep -v "Index"|grep -v "already exists"|wc -l`
    FAILED_INDEX=`grep "FAILED" ${LOG_PROCESS_FILE}|grep "Index"|grep "already exists"|wc -l`
    if [ ${RETVAL} -eq 0 ] || [[ ${FAILED_INDEX} -gt 0 && ${FAILED} -eq 0 ]]; then
        logger "Process is successfully."
    else
        logger "Process is failed."
        cleanExit 1
    fi
    
    rm ${IQL_SCRIPT_FILE}
}

${HADOOP_COMMAND_FS} -chmod -R g+w ${HFS_OUTPUT_FINAL_DIR}

echo "
USE STG;

--${TABLE_NAME}
CREATE TABLE IF NOT EXISTS ${TABLE_NAME}
(
STREAMTYPE STRING,
STREAMNAME STRING,
IDENTIFIER STRING,
CAMPAIGNID STRING,
CAMPAIGNCONTEXT STRING,
OCCUREDON STRING,
TRACKEDON STRING,
PRODUCEDON STRING,
PRODUCER STRING,
REASON STRING,
ISCONTROLGROUP STRING,
ELIGIBLECOUNTER TINYINT,
PROF_BRAND STRING, 
PROF_PRICEPLAN STRING,
PROF_REGION_HLR STRING,
PROF_DEVICE_TYPE STRING,
PROF_NAME STRING,
PROF_EMAIL STRING,
PROP_OWNER STRING,
PROP_PRODUCTGROUP STRING,
PROP_OBJECTIVE STRING,
PROP_TYPE STRING,
PROP_CATEGORY STRING,
SEG_CORE STRING,
SEG_SUB_CORE STRING,
SEG_OTHER STRING,
ATTR_LOC_KECAMATAN STRING,
ATTR_LOC_KABUPATEN STRING,
ATTR_LOC_REGION STRING,
ATTR_CLUSTER STRING,
ATTR_LAST_BALANCE DOUBLE,
ATTR_REVENUE INT,
ATTR_RECHARGE INT,
FILENAME STRING,
FILEDATE STRING)

PARTITIONED BY (
FILE_DATE STRING
)
STORED AS PARQUET
TBLPROPERTIES (\"parquet.compression\"=\"SNAPPY\");

ALTER TABLE ${TABLE_NAME} DROP IF EXISTS PARTITION (FILE_DATE='${PERIODE}');
ALTER TABLE ${TABLE_NAME} ADD IF NOT EXISTS PARTITION(FILE_DATE = ${PERIODE}); 

LOAD DATA INPATH '${HFS_OUTPUT_FINAL_DIR}' INTO TABLE ${TABLE_NAME} PARTITION(FILE_DATE = ${PERIODE});

" > ${IQL_SCRIPT_FILE}

execProc "Create table ${TABLE_NAME} or add data to partition PERIOD = ${PERIODE}"

if [ `echo $?` -eq 0 ] ;then
    logger "Load data ${PERIODE} is succesfully."
    logger "Update flag in tabel control..."
    
    #-update JOB_ID
    echo "
    START TRANSACTION;
    UPDATE TB_FILE_TO_JOB_SECURE SET TRANF_JOB_ID = '${JOB_ID}' WHERE FILEDATE = '${PERIODE}' AND SCP_ID = '${SCP_ID}' AND REAL_FILENAME IN (${REAL_FILENAME_LIST});
    COMMIT;" > ${LOG_FILE}.sql
    for (( I=1;I<=${MAX_LOOP};I++ )); do 
       ${MYSQL_HOME} -h${MYSQL_HOST} -u${MYSQL_USER} -p${MYSQL_PASSWORD} ${MYSQL_DB} < ${LOG_FILE}.sql > ${LOG_FILE}.upd 2>&1
       if [ `grep -v "^Warning" ${LOG_FILE}.upd | wc -l` -eq 0 ] && [ ${I} -le ${MAX_LOOP} ]; then
           break
       fi
    done
                                                                                       
    #check if file is empty
    if [ `grep -v "^Warning" ${LOG_FILE}.upd | wc -l` -gt 0 ]; then
        logger "Update table TB_FILE_TO_JOB_NE is failed. Log in ${LOG_FILE}.upd" 
        cleanExit 7
    fi
    #rm -f ${LOG_FILE}.upd ${LOG_FILE}.sql
else
    logger "Load data ${HFS_OUTPUT_FINAL_DIR} is failed."
    cleanExit 23
fi

logger "Process is done."

#-release lock
cleanExit 0

