<?xml version="1.0"?>
    <HGrid247 version="2.3.5">
        <Split>
            <name> TransformSplit_1510801381346</name>
            <ID> 1510801381346</ID>
            <label> TransformSplit_2</label>
            <prevPipe> </prevPipe>
           <type> TRANFORMATION</type>
            <pipeName> TransformSplit_1510801381346</pipeName>
            <maxPrevNode> 1</maxPrevNode>
            <flowName> </flowName>
            <inFields> line</inFields>
            <outFields> STREAMTYPE,STREAMNAME,IDENTIFIER,CAMPAIGNID,CAMPAIGNCONTEXT,OCCUREDON,TRACKEDON,PRODUCEDON,PRODUCER,REASON,ISCONTROLGROUP,ELIGIBLECOUNTER,PROF_BRAND,PROF_PRICEPLAN,PROF_REGION_HLR,PROF_DEVICE_TYPE,PROF_NAME,PROF_EMAIL,PROP_OWNER,PROP_PRODUCTGROUP,PROP_OBJECTIVE,PROP_TYPE,PROP_CATEGORY,SEG_CORE,SEG_SUB_CORE,SEG_OTHER,ATTR_LOC_KECAMATAN,ATTR_LOC_KABUPATEN,ATTR_LOC_REGION,ATTR_CLUSTER,ATTR_LAST_BALANCE,ATTR_REVENUE,ATTR_RECHARGE,FILENAME</outFields>
            <inFieldsType> String</inFieldsType>
            <outFieldsType> String,String,String,String,String,String,String,String,String,String,String,Integer,String,String,String,String,String,String,String,String,String,String,String,String,String,String,String,String,String,String,Double,Integer,Integer,String</outFieldsType>
            <posx> 194.0</posx>
            <posy> 210.0</posy>
            <tinggi> 47</tinggi>
            <lebar> 100</lebar>
            <enabled> true</enabled>
            <enabledCounter> true</enabledCounter>
            <description> </description>
            <argumentSelector> </argumentSelector>
            <outputSelector> </outputSelector>
            <fieldDeclaration> </fieldDeclaration>
            <posxIR> 22</posxIR>
            <posyIR> 22</posyIR>
            <posxOR> 500</posxOR>
            <posyOR> 20</posyOR>
            <widhtIR> 200</widhtIR>
            <heightIR> 37</heightIR>
            <widthOR> 244</widthOR>
            <heightOR> 630</heightOR>
        </Split>
        <Transform>
            <parentID> 1510801381346</parentID>
            <prevIDS> </prevIDS>
            <nextIDS> </nextIDS>
            <ID> 1510801406923</ID>
            <name> RegexSplitter</name>
            <label> RegexSplitter(|)</label>
            <input> line</input>
            <output> STREAMTYPE, STREAMNAME, IDENTIFIER, CAMPAIGNID, CAMPAIGNCONTEXT, OCCUREDON, TRACKEDON, PRODUCEDON, PRODUCER, REASON, ISCONTROLGROUP, ELIGIBLECOUNTER, PROF_BRAND, PROF_PRICEPLAN, PROF_REGION_HLR, PROF_DEVICE_TYPE, PROF_NAME, PROF_EMAIL, PROP_OWNER, PROP_PRODUCTGROUP, PROP_OBJECTIVE, PROP_TYPE, PROP_CATEGORY, SEG_CORE, SEG_SUB_CORE, SEG_OTHER, ATTR_LOC_KECAMATAN, ATTR_LOC_KABUPATEN, ATTR_LOC_REGION, ATTR_CLUSTER, ATTR_LAST_BALANCE, ATTR_REVENUE, ATTR_RECHARGE, FILENAME</output>
            <parameter> |</parameter>
            <posx> 242</posx>
            <posy> 211</posy>
            <inputCount> 1</inputCount>
            <outputCount> 2</outputCount>
            <codeString> </codeString>
            <expressionString> </expressionString>
            <defaultString> </defaultString>
            <extraInfo> </extraInfo>
            <udf> false</udf>
            <edited> false</edited>
            <freeCode> </freeCode>
        </Transform>
        <Each>
            <name> Transformator_1510801420971</name>
            <ID> 1510801420971</ID>
            <label> Transformator_2</label>
            <prevPipe> TransformSplit_1510801381346</prevPipe>
           <type> EACH</type>
            <pipeName> </pipeName>
            <maxPrevNode> 1</maxPrevNode>
            <flowName> </flowName>
            <inFields> STREAMTYPE,STREAMNAME,IDENTIFIER,CAMPAIGNID,CAMPAIGNCONTEXT,OCCUREDON,TRACKEDON,PRODUCEDON,PRODUCER,REASON,ISCONTROLGROUP,ELIGIBLECOUNTER,PROF_BRAND,PROF_PRICEPLAN,PROF_REGION_HLR,PROF_DEVICE_TYPE,PROF_NAME,PROF_EMAIL,PROP_OWNER,PROP_PRODUCTGROUP,PROP_OBJECTIVE,PROP_TYPE,PROP_CATEGORY,SEG_CORE,SEG_SUB_CORE,SEG_OTHER,ATTR_LOC_KECAMATAN,ATTR_LOC_KABUPATEN,ATTR_LOC_REGION,ATTR_CLUSTER,ATTR_LAST_BALANCE,ATTR_REVENUE,ATTR_RECHARGE,FILENAME</inFields>
            <outFields> STREAMTYPE,STREAMNAME,IDENTIFIER,CAMPAIGNID,CAMPAIGNCONTEXT,OCCUREDON,TRACKEDON,PRODUCEDON,PRODUCER,REASON,ISCONTROLGROUP,ELIGIBLECOUNTER,PROF_BRAND,PROF_PRICEPLAN,PROF_REGION_HLR,PROF_DEVICE_TYPE,PROF_NAME,PROF_EMAIL,PROP_OWNER,PROP_PRODUCTGROUP,PROP_OBJECTIVE,PROP_TYPE,PROP_CATEGORY,SEG_CORE,SEG_SUB_CORE,SEG_OTHER,ATTR_LOC_KECAMATAN,ATTR_LOC_KABUPATEN,ATTR_LOC_REGION,ATTR_CLUSTER,ATTR_LAST_BALANCE,ATTR_REVENUE,ATTR_RECHARGE,FILENAME,FILEDATE</outFields>
            <inFieldsType> String,String,String,String,String,String,String,String,String,String,String,Integer,String,String,String,String,String,String,String,String,String,String,String,String,String,String,String,String,String,String,Double,Integer,Integer,String</inFieldsType>
            <outFieldsType> String,String,String,String,String,String,String,String,String,String,String,Integer,String,String,String,String,String,String,String,String,String,String,String,String,String,String,String,String,String,String,Double,Integer,Integer,String,String</outFieldsType>
            <posx> 335.0</posx>
            <posy> 206.0</posy>
            <tinggi> 47</tinggi>
            <lebar> 90</lebar>
            <enabled> true</enabled>
            <enabledCounter> true</enabledCounter>
            <description> </description>
            <argumentSelector> </argumentSelector>
            <outputSelector> </outputSelector>
            <fieldDeclaration> </fieldDeclaration>
            <posxIR> 26</posxIR>
            <posyIR> 22</posyIR>
            <posxOR> 548</posxOR>
            <posyOR> 37</posyOR>
            <widhtIR> 250</widhtIR>
            <heightIR> 598</heightIR>
            <widthOR> 244</widthOR>
            <heightOR> 648</heightOR>
            <filterInstance> </filterInstance>
            <chaining> false</chaining>
        </Each>
        <Transform>
            <parentID> 1510801420971</parentID>
            <prevIDS> </prevIDS>
            <nextIDS> 1510801572145</nextIDS>
            <ID> 1510801477068</ID>
            <name> Tail</name>
            <label> Tail(_,2)</label>
            <input> FILENAME</input>
            <output> </output>
            <parameter> _,2</parameter>
            <posx> 299</posx>
            <posy> 607</posy>
            <inputCount> 1</inputCount>
            <outputCount> 2</outputCount>
            <codeString> </codeString>
            <expressionString> </expressionString>
            <defaultString> </defaultString>
            <extraInfo> CMC_CP_20171031ttk_signdatttk_signgz</extraInfo>
            <udf> false</udf>
            <edited> false</edited>
            <freeCode> </freeCode>
        </Transform>
        <Transform>
            <parentID> 1510801420971</parentID>
            <prevIDS> 1510801477068</prevIDS>
            <nextIDS> </nextIDS>
            <ID> 1510801572145</ID>
            <name> Substring</name>
            <label> Substring(0,8)</label>
            <input> </input>
            <output> FILEDATE</output>
            <parameter> 0,8</parameter>
            <posx> 392</posx>
            <posy> 596</posy>
            <inputCount> 1</inputCount>
            <outputCount> 2</outputCount>
            <codeString> </codeString>
            <expressionString> </expressionString>
            <defaultString> </defaultString>
            <extraInfo> </extraInfo>
            <udf> false</udf>
            <edited> false</edited>
            <freeCode> </freeCode>
        </Transform>
        <Identity>
            <parentID> 1510801420971</parentID>
            <fromField> STREAMTYPE</fromField>
            <toField> STREAMTYPE</toField>
        </Identity>
        <Identity>
            <parentID> 1510801420971</parentID>
            <fromField> STREAMNAME</fromField>
            <toField> STREAMNAME</toField>
        </Identity>
        <Identity>
            <parentID> 1510801420971</parentID>
            <fromField> IDENTIFIER</fromField>
            <toField> IDENTIFIER</toField>
        </Identity>
        <Identity>
            <parentID> 1510801420971</parentID>
            <fromField> CAMPAIGNID</fromField>
            <toField> CAMPAIGNID</toField>
        </Identity>
        <Identity>
            <parentID> 1510801420971</parentID>
            <fromField> CAMPAIGNCONTEXT</fromField>
            <toField> CAMPAIGNCONTEXT</toField>
        </Identity>
        <Identity>
            <parentID> 1510801420971</parentID>
            <fromField> OCCUREDON</fromField>
            <toField> OCCUREDON</toField>
        </Identity>
        <Identity>
            <parentID> 1510801420971</parentID>
            <fromField> TRACKEDON</fromField>
            <toField> TRACKEDON</toField>
        </Identity>
        <Identity>
            <parentID> 1510801420971</parentID>
            <fromField> PRODUCEDON</fromField>
            <toField> PRODUCEDON</toField>
        </Identity>
        <Identity>
            <parentID> 1510801420971</parentID>
            <fromField> PRODUCER</fromField>
            <toField> PRODUCER</toField>
        </Identity>
        <Identity>
            <parentID> 1510801420971</parentID>
            <fromField> REASON</fromField>
            <toField> REASON</toField>
        </Identity>
        <Identity>
            <parentID> 1510801420971</parentID>
            <fromField> ISCONTROLGROUP</fromField>
            <toField> ISCONTROLGROUP</toField>
        </Identity>
        <Identity>
            <parentID> 1510801420971</parentID>
            <fromField> ELIGIBLECOUNTER</fromField>
            <toField> ELIGIBLECOUNTER</toField>
        </Identity>
        <Identity>
            <parentID> 1510801420971</parentID>
            <fromField> PROF_BRAND</fromField>
            <toField> PROF_BRAND</toField>
        </Identity>
        <Identity>
            <parentID> 1510801420971</parentID>
            <fromField> PROF_PRICEPLAN</fromField>
            <toField> PROF_PRICEPLAN</toField>
        </Identity>
        <Identity>
            <parentID> 1510801420971</parentID>
            <fromField> PROF_REGION_HLR</fromField>
            <toField> PROF_REGION_HLR</toField>
        </Identity>
        <Identity>
            <parentID> 1510801420971</parentID>
            <fromField> PROF_DEVICE_TYPE</fromField>
            <toField> PROF_DEVICE_TYPE</toField>
        </Identity>
        <Identity>
            <parentID> 1510801420971</parentID>
            <fromField> PROF_NAME</fromField>
            <toField> PROF_NAME</toField>
        </Identity>
        <Identity>
            <parentID> 1510801420971</parentID>
            <fromField> PROF_EMAIL</fromField>
            <toField> PROF_EMAIL</toField>
        </Identity>
        <Identity>
            <parentID> 1510801420971</parentID>
            <fromField> PROP_OWNER</fromField>
            <toField> PROP_OWNER</toField>
        </Identity>
        <Identity>
            <parentID> 1510801420971</parentID>
            <fromField> PROP_PRODUCTGROUP</fromField>
            <toField> PROP_PRODUCTGROUP</toField>
        </Identity>
        <Identity>
            <parentID> 1510801420971</parentID>
            <fromField> PROP_OBJECTIVE</fromField>
            <toField> PROP_OBJECTIVE</toField>
        </Identity>
        <Identity>
            <parentID> 1510801420971</parentID>
            <fromField> PROP_TYPE</fromField>
            <toField> PROP_TYPE</toField>
        </Identity>
        <Identity>
            <parentID> 1510801420971</parentID>
            <fromField> PROP_CATEGORY</fromField>
            <toField> PROP_CATEGORY</toField>
        </Identity>
        <Identity>
            <parentID> 1510801420971</parentID>
            <fromField> SEG_CORE</fromField>
            <toField> SEG_CORE</toField>
        </Identity>
        <Identity>
            <parentID> 1510801420971</parentID>
            <fromField> SEG_SUB_CORE</fromField>
            <toField> SEG_SUB_CORE</toField>
        </Identity>
        <Identity>
            <parentID> 1510801420971</parentID>
            <fromField> SEG_OTHER</fromField>
            <toField> SEG_OTHER</toField>
        </Identity>
        <Identity>
            <parentID> 1510801420971</parentID>
            <fromField> ATTR_LOC_KECAMATAN</fromField>
            <toField> ATTR_LOC_KECAMATAN</toField>
        </Identity>
        <Identity>
            <parentID> 1510801420971</parentID>
            <fromField> ATTR_LOC_KABUPATEN</fromField>
            <toField> ATTR_LOC_KABUPATEN</toField>
        </Identity>
        <Identity>
            <parentID> 1510801420971</parentID>
            <fromField> ATTR_LOC_REGION</fromField>
            <toField> ATTR_LOC_REGION</toField>
        </Identity>
        <Identity>
            <parentID> 1510801420971</parentID>
            <fromField> ATTR_CLUSTER</fromField>
            <toField> ATTR_CLUSTER</toField>
        </Identity>
        <Identity>
            <parentID> 1510801420971</parentID>
            <fromField> ATTR_LAST_BALANCE</fromField>
            <toField> ATTR_LAST_BALANCE</toField>
        </Identity>
        <Identity>
            <parentID> 1510801420971</parentID>
            <fromField> ATTR_REVENUE</fromField>
            <toField> ATTR_REVENUE</toField>
        </Identity>
        <Identity>
            <parentID> 1510801420971</parentID>
            <fromField> ATTR_RECHARGE</fromField>
            <toField> ATTR_RECHARGE</toField>
        </Identity>
        <Identity>
            <parentID> 1510801420971</parentID>
            <fromField> FILENAME</fromField>
            <toField> FILENAME</toField>
        </Identity>
        <Pipe2Hfs>
            <fromID> 1510801420971</fromID>
            <toID> 1510828704611</toID>
        </Pipe2Hfs>
        <Pipe>
            <name> pipe_1510801666886</name>
            <ID> 1510801666886</ID>
            <label> pipe_1</label>
            <prevPipe> TransformSplit_1510801381346</prevPipe>
           <type> PIPE</type>
            <pipeName> </pipeName>
            <maxPrevNode> 1</maxPrevNode>
            <flowName> </flowName>
            <inFields> line,ERR_MSG</inFields>
            <outFields> line,ERR_MSG</outFields>
            <inFieldsType> String,String</inFieldsType>
            <outFieldsType> String,String</outFieldsType>
            <posx> 196.0</posx>
            <posy> 305.0</posy>
            <tinggi> 46</tinggi>
            <lebar> 38</lebar>
            <enabled> true</enabled>
            <enabledCounter> true</enabledCounter>
            <description> </description>
        </Pipe>
        <Pipe2Hfs>
            <fromID> 1510801666886</fromID>
            <toID> 1510801679778</toID>
        </Pipe2Hfs>
        <Pipe2Pipe>
            <fromID> 1510801381346</fromID>
            <toID> 1510801420971</toID>
            <color> black</color>
        </Pipe2Pipe>
        <Pipe2Pipe>
            <fromID> 1510801381346</fromID>
            <toID> 1510801666886</toID>
            <color> red</color>
        </Pipe2Pipe>
        <HfsSink>
            <fields> </fields>
            <path> </path>
            <sinkMode> </sinkMode>
            <label> Hfs_sink_1</label>
             <hfsName> Hfs_sink_1510801679778</hfsName>
            <ID> 1510801679778</ID>
            <type> HFSSINK</type>
            <posx> 200.0</posx>
            <posy> 401.0</posy>
            <inputdir> </inputdir>
            <outputdir> </outputdir>
            <testdir> </testdir>
            <tableHeader> </tableHeader>
            <outputWithDate>false</outputWithDate>
            <headerDelimited></headerDelimited>
            <outputFormat>hgrid247-#####</outputFormat>
            <fileType> Hfs</fileType>
            <fieldNames> </fieldNames>
            <enabled> true</enabled>
            <enabledCounter> true</enabledCounter>
            <argumentOrder> 1</argumentOrder>
            <description> </description>
            <schemeClass> </schemeClass>
            <delimiter> </delimiter>
            <fieldGroupPartition> </fieldGroupPartition>
            <incomingFields> line,ERR_MSG</incomingFields>
            <partDelimiter> </partDelimiter>
            <partIndex> </partIndex>
            <rejectedHfs> false</rejectedHfs>
            <sourceFields> </sourceFields>
            <sinkFields> </sinkFields>
            <numSinkPart> </numSinkPart>
        </HfsSink>
        <ParquetSink>
            <fields> </fields>
            <path> </path>
            <sinkMode> SinkMode.REPLACE</sinkMode>
            <label> ParquetSink_3</label>
             <hfsName> ParquetSink_1510828704611</hfsName>
            <ID> 1510828704611</ID>
            <type> PARQUETSINK</type>
            <posx> 461.0</posx>
            <posy> 204.0</posy>
            <inputdir> </inputdir>
            <outputdir> </outputdir>
            <testdir> </testdir>
            <tableHeader> </tableHeader>
            <outputWithDate>false</outputWithDate>
            <headerDelimited></headerDelimited>
            <outputFormat>hgrid247-#####</outputFormat>
            <fileType> Hfs</fileType>
            <fieldNames> </fieldNames>
            <enabled> true</enabled>
            <enabledCounter> true</enabledCounter>
            <argumentOrder> 3</argumentOrder>
            <description> </description>
            <schemeClass> </schemeClass>
            <delimiter> </delimiter>
            <fieldGroupPartition> </fieldGroupPartition>
            <incomingFields> STREAMTYPE,STREAMNAME,IDENTIFIER,CAMPAIGNID,CAMPAIGNCONTEXT,OCCUREDON,TRACKEDON,PRODUCEDON,PRODUCER,REASON,ISCONTROLGROUP,ELIGIBLECOUNTER,PROF_BRAND,PROF_PRICEPLAN,PROF_REGION_HLR,PROF_DEVICE_TYPE,PROF_NAME,PROF_EMAIL,PROP_OWNER,PROP_PRODUCTGROUP,PROP_OBJECTIVE,PROP_TYPE,PROP_CATEGORY,SEG_CORE,SEG_SUB_CORE,SEG_OTHER,ATTR_LOC_KECAMATAN,ATTR_LOC_KABUPATEN,ATTR_LOC_REGION,ATTR_CLUSTER,ATTR_LAST_BALANCE,ATTR_REVENUE,ATTR_RECHARGE,FILENAME,FILEDATE</incomingFields>
            <partDelimiter> </partDelimiter>
            <partIndex> </partIndex>
            <rejectedHfs> false</rejectedHfs>
            <sourceFields> </sourceFields>
            <sinkFields> </sinkFields>
            <numSinkPart> </numSinkPart>
            <columnFields> STREAMTYPE,STREAMNAME,IDENTIFIER,CAMPAIGNID,CAMPAIGNCONTEXT,OCCUREDON,TRACKEDON,PRODUCEDON,PRODUCER,REASON,ISCONTROLGROUP,ELIGIBLECOUNTER,PROF_BRAND,PROF_PRICEPLAN,PROF_REGION_HLR,PROF_DEVICE_TYPE,PROF_NAME,PROF_EMAIL,PROP_OWNER,PROP_PRODUCTGROUP,PROP_OBJECTIVE,PROP_TYPE,PROP_CATEGORY,SEG_CORE,SEG_SUB_CORE,SEG_OTHER,ATTR_LOC_KECAMATAN,ATTR_LOC_KABUPATEN,ATTR_LOC_REGION,ATTR_CLUSTER,ATTR_LAST_BALANCE,ATTR_REVENUE,ATTR_RECHARGE,FILENAME,FILEDATE</columnFields>
            <fieldsType> String,String,String,String,String,String,String,String,String,String,String,Integer,String,String,String,String,String,String,String,String,String,String,String,String,String,String,String,String,String,String,Double,Integer,Integer,String,String</fieldsType>
            <compressionCodec> CompressionCodecName.SNAPPY</compressionCodec>
            <blockSize> Default</blockSize>
            <pageSize> Default</pageSize>
        </ParquetSink>
        <HfsSource>
            <fields> </fields>
            <path> input_Hfs_source_1510801132280</path>
            <sinkMode> </sinkMode>
            <label> Cms</label>
             <hfsName> Hfs_source_1510801132280</hfsName>
            <ID> 1510801132280</ID>
            <type> HFSSOURCE</type>
            <posx> 85.0</posx>
            <posy> 214.0</posy>
            <inputdir> </inputdir>
            <outputdir> </outputdir>
            <testdir> </testdir>
            <tableHeader> </tableHeader>
            <outputWithDate>false</outputWithDate>
            <headerDelimited></headerDelimited>
            <outputFormat>hgrid247-#####</outputFormat>
            <fileType> Hfs</fileType>
            <fieldNames> </fieldNames>
            <enabled> true</enabled>
            <enabledCounter> true</enabledCounter>
            <argumentOrder> 0</argumentOrder>
            <description> </description>
            <schemeClass> </schemeClass>
            <delimiter> |</delimiter>
            <fieldGroupPartition> </fieldGroupPartition>
            <incomingFields> </incomingFields>
            <partDelimiter> </partDelimiter>
            <partIndex> </partIndex>
            <rejectedHfs> false</rejectedHfs>
            <sourceFields> </sourceFields>
            <sinkFields> </sinkFields>
            <numSinkPart> </numSinkPart>
             <combined>true</combined>
             <includeFile>true</includeFile>
        </HfsSource>
        <Hfs2Pipe>
            <fromID> 1510801132280</fromID>
            <toID> 1510801381346</toID>
        </Hfs2Pipe>
        <FlowProperty>
            <ReducerNumber> </ReducerNumber>
            <MapNumber> </MapNumber>
            <actionInputDir> L</actionInputDir>
            <compresstype> DefaultCodec</compresstype>
            <jobTrackerUrl> localhost:50030</jobTrackerUrl>
            <graphDisplay> false</graphDisplay>
            <mapOutputCompressed> false</mapOutputCompressed>
            <description> </description>
            <logPath> </logPath>
            <speculativeExecution> </speculativeExecution>
            <ingoreUnexistsPath> No</ingoreUnexistsPath>
            <combinedInput> false</combinedInput>
            <maxSplitSize> 128</maxSplitSize>
            <fileNdelimiter> No,|</fileNdelimiter>
            <reuseJVM> false</reuseJVM>
            <zoom> 1.0</zoom>
            <jobConf> io.compression.codecs,nl.basjes.hadoop.io.compress.SplittableGzipCodec;mapreduce.job.queuename,root.hsi_nat.hsi_nat_small;mapreduce.reduce.memory.mb,4096;mapred.reduce.tasks,5;mapreduce.map.java.opts,-Xmx3600m;mapreduce.map.memory.mb,4096</jobConf>
            <logLoc> Local</logLoc>
        </FlowProperty>
    </HGrid247>
