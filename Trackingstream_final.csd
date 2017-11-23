<?xml version="1.0"?>
    <HGrid247 version="2.3.5">
        <Each>
            <name> Transformator_1511249669474</name>
            <ID> 1511249669474</ID>
            <label> Transformator_3</label>
            <prevPipe> </prevPipe>
           <type> EACH</type>
            <pipeName> Transformator_1511249669474</pipeName>
            <maxPrevNode> 0</maxPrevNode>
            <flowName> </flowName>
            <inFields> streamtype,streamname,identifier,campaignid,campaigncontext,occuredon,trackedon,producedon,producer,reason,iscontrolgroup,eligiblecounter,prof_brand,prof_priceplan,prof_region_hlr,prof_device_type,prof_name,prof_email,prop_owner,prop_productgroup,prop_objective,prop_type,prop_category,seg_core,seg_sub_core,seg_other,attr_loc_kecamatan,attr_loc_kabupaten,attr_loc_region,attr_cluster,attr_last_balance,attr_revenue,attr_recharge,filename,filedate</inFields>
            <outFields> streamtype,streamname,identifier,campaignid,campaigncontext,occuredon,trackedon,producedon,producer,reason,iscontrolgroup,eligiblecounter,prof_brand,prof_priceplan,prof_region_hlr,prof_device_type,prof_name,prof_email,prop_owner,prop_productgroup,prop_objective,prop_type,prop_category,seg_core,seg_sub_core,seg_other,attr_loc_kecamatan,attr_loc_kabupaten,attr_loc_region,attr_cluster,attr_last_balance,attr_revenue,attr_recharge,filename,filedate,counter</outFields>
            <inFieldsType> String,String,String,String,String,String,String,String,String,String,String,Integer,String,String,String,String,String,String,String,String,String,String,String,String,String,String,String,String,String,String,Float,Integer,Integer,String,String</inFieldsType>
            <outFieldsType> String,String,String,String,String,String,String,String,String,String,String,Integer,String,String,String,String,String,String,String,String,String,String,String,String,String,String,String,String,String,String,Float,Integer,Integer,String,String,String</outFieldsType>
            <posx> 195.0</posx>
            <posy> 246.0</posy>
            <tinggi> 43</tinggi>
            <lebar> 90</lebar>
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
            <widhtIR> 260</widhtIR>
            <heightIR> 615</heightIR>
            <widthOR> 252</widthOR>
            <heightOR> 666</heightOR>
            <filterInstance> </filterInstance>
            <chaining> false</chaining>
        </Each>
        <Transform>
            <parentID> 1511249669474</parentID>
            <prevIDS> </prevIDS>
            <nextIDS> </nextIDS>
            <ID> 1511249691037</ID>
            <name> cascading.solusi247.transform.field.Counter</name>
            <label> Counter()</label>
            <input> </input>
            <output> counter</output>
            <parameter> </parameter>
            <posx> 363</posx>
            <posy> 609</posy>
            <inputCount> 0</inputCount>
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
            <parentID> 1511249669474</parentID>
            <fromField> streamtype</fromField>
            <toField> streamtype</toField>
        </Identity>
        <Identity>
            <parentID> 1511249669474</parentID>
            <fromField> streamname</fromField>
            <toField> streamname</toField>
        </Identity>
        <Identity>
            <parentID> 1511249669474</parentID>
            <fromField> identifier</fromField>
            <toField> identifier</toField>
        </Identity>
        <Identity>
            <parentID> 1511249669474</parentID>
            <fromField> campaignid</fromField>
            <toField> campaignid</toField>
        </Identity>
        <Identity>
            <parentID> 1511249669474</parentID>
            <fromField> campaigncontext</fromField>
            <toField> campaigncontext</toField>
        </Identity>
        <Identity>
            <parentID> 1511249669474</parentID>
            <fromField> occuredon</fromField>
            <toField> occuredon</toField>
        </Identity>
        <Identity>
            <parentID> 1511249669474</parentID>
            <fromField> trackedon</fromField>
            <toField> trackedon</toField>
        </Identity>
        <Identity>
            <parentID> 1511249669474</parentID>
            <fromField> producedon</fromField>
            <toField> producedon</toField>
        </Identity>
        <Identity>
            <parentID> 1511249669474</parentID>
            <fromField> producer</fromField>
            <toField> producer</toField>
        </Identity>
        <Identity>
            <parentID> 1511249669474</parentID>
            <fromField> reason</fromField>
            <toField> reason</toField>
        </Identity>
        <Identity>
            <parentID> 1511249669474</parentID>
            <fromField> iscontrolgroup</fromField>
            <toField> iscontrolgroup</toField>
        </Identity>
        <Identity>
            <parentID> 1511249669474</parentID>
            <fromField> eligiblecounter</fromField>
            <toField> eligiblecounter</toField>
        </Identity>
        <Identity>
            <parentID> 1511249669474</parentID>
            <fromField> prof_brand</fromField>
            <toField> prof_brand</toField>
        </Identity>
        <Identity>
            <parentID> 1511249669474</parentID>
            <fromField> prof_priceplan</fromField>
            <toField> prof_priceplan</toField>
        </Identity>
        <Identity>
            <parentID> 1511249669474</parentID>
            <fromField> prof_region_hlr</fromField>
            <toField> prof_region_hlr</toField>
        </Identity>
        <Identity>
            <parentID> 1511249669474</parentID>
            <fromField> prof_device_type</fromField>
            <toField> prof_device_type</toField>
        </Identity>
        <Identity>
            <parentID> 1511249669474</parentID>
            <fromField> prof_name</fromField>
            <toField> prof_name</toField>
        </Identity>
        <Identity>
            <parentID> 1511249669474</parentID>
            <fromField> prof_email</fromField>
            <toField> prof_email</toField>
        </Identity>
        <Identity>
            <parentID> 1511249669474</parentID>
            <fromField> prop_owner</fromField>
            <toField> prop_owner</toField>
        </Identity>
        <Identity>
            <parentID> 1511249669474</parentID>
            <fromField> prop_productgroup</fromField>
            <toField> prop_productgroup</toField>
        </Identity>
        <Identity>
            <parentID> 1511249669474</parentID>
            <fromField> prop_objective</fromField>
            <toField> prop_objective</toField>
        </Identity>
        <Identity>
            <parentID> 1511249669474</parentID>
            <fromField> prop_type</fromField>
            <toField> prop_type</toField>
        </Identity>
        <Identity>
            <parentID> 1511249669474</parentID>
            <fromField> prop_category</fromField>
            <toField> prop_category</toField>
        </Identity>
        <Identity>
            <parentID> 1511249669474</parentID>
            <fromField> seg_core</fromField>
            <toField> seg_core</toField>
        </Identity>
        <Identity>
            <parentID> 1511249669474</parentID>
            <fromField> seg_sub_core</fromField>
            <toField> seg_sub_core</toField>
        </Identity>
        <Identity>
            <parentID> 1511249669474</parentID>
            <fromField> seg_other</fromField>
            <toField> seg_other</toField>
        </Identity>
        <Identity>
            <parentID> 1511249669474</parentID>
            <fromField> attr_loc_kecamatan</fromField>
            <toField> attr_loc_kecamatan</toField>
        </Identity>
        <Identity>
            <parentID> 1511249669474</parentID>
            <fromField> attr_loc_kabupaten</fromField>
            <toField> attr_loc_kabupaten</toField>
        </Identity>
        <Identity>
            <parentID> 1511249669474</parentID>
            <fromField> attr_loc_region</fromField>
            <toField> attr_loc_region</toField>
        </Identity>
        <Identity>
            <parentID> 1511249669474</parentID>
            <fromField> attr_cluster</fromField>
            <toField> attr_cluster</toField>
        </Identity>
        <Identity>
            <parentID> 1511249669474</parentID>
            <fromField> attr_last_balance</fromField>
            <toField> attr_last_balance</toField>
        </Identity>
        <Identity>
            <parentID> 1511249669474</parentID>
            <fromField> attr_revenue</fromField>
            <toField> attr_revenue</toField>
        </Identity>
        <Identity>
            <parentID> 1511249669474</parentID>
            <fromField> attr_recharge</fromField>
            <toField> attr_recharge</toField>
        </Identity>
        <Identity>
            <parentID> 1511249669474</parentID>
            <fromField> filename</fromField>
            <toField> filename</toField>
        </Identity>
        <Identity>
            <parentID> 1511249669474</parentID>
            <fromField> filedate</fromField>
            <toField> filedate</toField>
        </Identity>
        <Groupby>
            <name> GroupBy_1511249740441</name>
            <ID> 1511249740441</ID>
            <label> GroupBy_2</label>
            <prevPipe> Transformator_1511249669474</prevPipe>
           <type> GROUPBY</type>
            <pipeName> </pipeName>
            <maxPrevNode> 0</maxPrevNode>
            <flowName> </flowName>
            <inFields> streamtype,streamname,identifier,campaignid,campaigncontext,occuredon,trackedon,producedon,producer,reason,iscontrolgroup,eligiblecounter,prof_brand,prof_priceplan,prof_region_hlr,prof_device_type,prof_name,prof_email,prop_owner,prop_productgroup,prop_objective,prop_type,prop_category,seg_core,seg_sub_core,seg_other,attr_loc_kecamatan,attr_loc_kabupaten,attr_loc_region,attr_cluster,attr_last_balance,attr_revenue,attr_recharge,filename,filedate,counter</inFields>
            <outFields> streamtype,streamname,identifier,campaignid,campaigncontext,occuredon,trackedon,producedon,producer,reason,iscontrolgroup,eligiblecounter,prof_brand,prof_priceplan,prof_region_hlr,prof_device_type,prof_name,prof_email,prop_owner,prop_productgroup,prop_objective,prop_type,prop_category,seg_core,seg_sub_core,seg_other,attr_loc_kecamatan,attr_loc_kabupaten,attr_loc_region,attr_cluster,attr_last_balance,attr_revenue,attr_recharge,filename,filedate,counter</outFields>
            <inFieldsType> String,String,String,String,String,String,String,String,String,String,String,Integer,String,String,String,String,String,String,String,String,String,String,String,String,String,String,String,String,String,String,Float,Integer,Integer,String,String,String</inFieldsType>
            <outFieldsType> String,String,String,String,String,String,String,String,String,String,String,Integer,String,String,String,String,String,String,String,String,String,String,String,String,String,String,String,String,String,String,Float,Integer,Integer,String,String,String</outFieldsType>
            <posx> 297.0</posx>
            <posy> 248.0</posy>
            <tinggi> 43</tinggi>
            <lebar> 62</lebar>
            <enabled> true</enabled>
            <enabledCounter> true</enabledCounter>
            <description> </description>
            <groupFields> counter</groupFields>
            <sortFields> </sortFields>
            <reverseOrder> false</reverseOrder>
            <groupName> </groupName>
            <sortOrder> </sortOrder>
        </Groupby>
        <Each>
            <name> Transformator_1511249751270</name>
            <ID> 1511249751270</ID>
            <label> Transformator_4</label>
            <prevPipe> GroupBy_1511249740441</prevPipe>
           <type> EACH</type>
            <pipeName> </pipeName>
            <maxPrevNode> 0</maxPrevNode>
            <flowName> </flowName>
            <inFields> streamtype,streamname,identifier,campaignid,campaigncontext,occuredon,trackedon,producedon,producer,reason,iscontrolgroup,eligiblecounter,prof_brand,prof_priceplan,prof_region_hlr,prof_device_type,prof_name,prof_email,prop_owner,prop_productgroup,prop_objective,prop_type,prop_category,seg_core,seg_sub_core,seg_other,attr_loc_kecamatan,attr_loc_kabupaten,attr_loc_region,attr_cluster,attr_last_balance,attr_revenue,attr_recharge,filename,filedate,counter</inFields>
            <outFields> streamtype,streamname,identifier,campaignid,campaigncontext,occuredon,trackedon,producedon,producer,reason,iscontrolgroup,eligiblecounter,prof_brand,prof_priceplan,prof_region_hlr,prof_device_type,prof_name,prof_email,prop_owner,prop_productgroup,prop_objective,prop_type,prop_category,seg_core,seg_sub_core,seg_other,attr_loc_kecamatan,attr_loc_kabupaten,attr_loc_region,attr_cluster,attr_last_balance,attr_revenue,attr_recharge,filename,filedate</outFields>
            <inFieldsType> String,String,String,String,String,String,String,String,String,String,String,Integer,String,String,String,String,String,String,String,String,String,String,String,String,String,String,String,String,String,String,Float,Integer,Integer,String,String,String</inFieldsType>
            <outFieldsType> String,String,String,String,String,String,String,String,String,String,String,Integer,String,String,String,String,String,String,String,String,String,String,String,String,String,String,String,String,String,String,Float,Integer,Integer,String,String</outFieldsType>
            <posx> 409.0</posx>
            <posy> 248.0</posy>
            <tinggi> 43</tinggi>
            <lebar> 90</lebar>
            <enabled> true</enabled>
            <enabledCounter> true</enabledCounter>
            <description> </description>
            <argumentSelector> streamtype,streamname,identifier,campaignid,campaigncontext,occuredon,trackedon,producedon,producer,reason,iscontrolgroup,eligiblecounter,prof_brand,prof_priceplan,prof_region_hlr,prof_device_type,prof_name,prof_email,prop_owner,prop_productgroup,prop_objective,prop_type,prop_category,seg_core,seg_sub_core,seg_other,attr_loc_kecamatan,attr_loc_kabupaten,attr_loc_region,attr_cluster,attr_last_balance,attr_revenue,attr_recharge,filename,filedate,counter</argumentSelector>
            <outputSelector> </outputSelector>
            <fieldDeclaration> </fieldDeclaration>
            <posxIR> 22</posxIR>
            <posyIR> 22</posyIR>
            <posxOR> 500</posxOR>
            <posyOR> 20</posyOR>
            <widhtIR> 260</widhtIR>
            <heightIR> 632</heightIR>
            <widthOR> 260</widthOR>
            <heightOR> 632</heightOR>
            <filterInstance> </filterInstance>
            <chaining> false</chaining>
        </Each>
        <Identity>
            <parentID> 1511249751270</parentID>
            <fromField> streamtype</fromField>
            <toField> streamtype</toField>
        </Identity>
        <Identity>
            <parentID> 1511249751270</parentID>
            <fromField> streamname</fromField>
            <toField> streamname</toField>
        </Identity>
        <Identity>
            <parentID> 1511249751270</parentID>
            <fromField> identifier</fromField>
            <toField> identifier</toField>
        </Identity>
        <Identity>
            <parentID> 1511249751270</parentID>
            <fromField> campaignid</fromField>
            <toField> campaignid</toField>
        </Identity>
        <Identity>
            <parentID> 1511249751270</parentID>
            <fromField> campaigncontext</fromField>
            <toField> campaigncontext</toField>
        </Identity>
        <Identity>
            <parentID> 1511249751270</parentID>
            <fromField> occuredon</fromField>
            <toField> occuredon</toField>
        </Identity>
        <Identity>
            <parentID> 1511249751270</parentID>
            <fromField> trackedon</fromField>
            <toField> trackedon</toField>
        </Identity>
        <Identity>
            <parentID> 1511249751270</parentID>
            <fromField> producedon</fromField>
            <toField> producedon</toField>
        </Identity>
        <Identity>
            <parentID> 1511249751270</parentID>
            <fromField> producer</fromField>
            <toField> producer</toField>
        </Identity>
        <Identity>
            <parentID> 1511249751270</parentID>
            <fromField> reason</fromField>
            <toField> reason</toField>
        </Identity>
        <Identity>
            <parentID> 1511249751270</parentID>
            <fromField> iscontrolgroup</fromField>
            <toField> iscontrolgroup</toField>
        </Identity>
        <Identity>
            <parentID> 1511249751270</parentID>
            <fromField> eligiblecounter</fromField>
            <toField> eligiblecounter</toField>
        </Identity>
        <Identity>
            <parentID> 1511249751270</parentID>
            <fromField> prof_brand</fromField>
            <toField> prof_brand</toField>
        </Identity>
        <Identity>
            <parentID> 1511249751270</parentID>
            <fromField> prof_priceplan</fromField>
            <toField> prof_priceplan</toField>
        </Identity>
        <Identity>
            <parentID> 1511249751270</parentID>
            <fromField> prof_region_hlr</fromField>
            <toField> prof_region_hlr</toField>
        </Identity>
        <Identity>
            <parentID> 1511249751270</parentID>
            <fromField> prof_device_type</fromField>
            <toField> prof_device_type</toField>
        </Identity>
        <Identity>
            <parentID> 1511249751270</parentID>
            <fromField> prof_name</fromField>
            <toField> prof_name</toField>
        </Identity>
        <Identity>
            <parentID> 1511249751270</parentID>
            <fromField> prof_email</fromField>
            <toField> prof_email</toField>
        </Identity>
        <Identity>
            <parentID> 1511249751270</parentID>
            <fromField> prop_owner</fromField>
            <toField> prop_owner</toField>
        </Identity>
        <Identity>
            <parentID> 1511249751270</parentID>
            <fromField> prop_productgroup</fromField>
            <toField> prop_productgroup</toField>
        </Identity>
        <Identity>
            <parentID> 1511249751270</parentID>
            <fromField> prop_objective</fromField>
            <toField> prop_objective</toField>
        </Identity>
        <Identity>
            <parentID> 1511249751270</parentID>
            <fromField> prop_type</fromField>
            <toField> prop_type</toField>
        </Identity>
        <Identity>
            <parentID> 1511249751270</parentID>
            <fromField> prop_category</fromField>
            <toField> prop_category</toField>
        </Identity>
        <Identity>
            <parentID> 1511249751270</parentID>
            <fromField> seg_core</fromField>
            <toField> seg_core</toField>
        </Identity>
        <Identity>
            <parentID> 1511249751270</parentID>
            <fromField> seg_sub_core</fromField>
            <toField> seg_sub_core</toField>
        </Identity>
        <Identity>
            <parentID> 1511249751270</parentID>
            <fromField> seg_other</fromField>
            <toField> seg_other</toField>
        </Identity>
        <Identity>
            <parentID> 1511249751270</parentID>
            <fromField> attr_loc_kecamatan</fromField>
            <toField> attr_loc_kecamatan</toField>
        </Identity>
        <Identity>
            <parentID> 1511249751270</parentID>
            <fromField> attr_loc_kabupaten</fromField>
            <toField> attr_loc_kabupaten</toField>
        </Identity>
        <Identity>
            <parentID> 1511249751270</parentID>
            <fromField> attr_loc_region</fromField>
            <toField> attr_loc_region</toField>
        </Identity>
        <Identity>
            <parentID> 1511249751270</parentID>
            <fromField> attr_cluster</fromField>
            <toField> attr_cluster</toField>
        </Identity>
        <Identity>
            <parentID> 1511249751270</parentID>
            <fromField> attr_last_balance</fromField>
            <toField> attr_last_balance</toField>
        </Identity>
        <Identity>
            <parentID> 1511249751270</parentID>
            <fromField> attr_revenue</fromField>
            <toField> attr_revenue</toField>
        </Identity>
        <Identity>
            <parentID> 1511249751270</parentID>
            <fromField> attr_recharge</fromField>
            <toField> attr_recharge</toField>
        </Identity>
        <Identity>
            <parentID> 1511249751270</parentID>
            <fromField> filename</fromField>
            <toField> filename</toField>
        </Identity>
        <Identity>
            <parentID> 1511249751270</parentID>
            <fromField> filedate</fromField>
            <toField> filedate</toField>
        </Identity>
        <Pipe2Hfs>
            <fromID> 1511249751270</fromID>
            <toID> 1511249799145</toID>
        </Pipe2Hfs>
        <Pipe2Pipe>
            <fromID> 1511249669474</fromID>
            <toID> 1511249740441</toID>
            <color> black</color>
        </Pipe2Pipe>
        <Pipe2Pipe>
            <fromID> 1511249740441</fromID>
            <toID> 1511249751270</toID>
            <color> black</color>
        </Pipe2Pipe>
        <ParquetSink>
            <fields> </fields>
            <path> </path>
            <sinkMode> SinkMode.REPLACE</sinkMode>
            <label> ParquetSink_2</label>
             <hfsName> ParquetSink_1511249799145</hfsName>
            <ID> 1511249799145</ID>
            <type> PARQUETSINK</type>
            <posx> 545.0</posx>
            <posy> 255.0</posy>
            <inputdir> </inputdir>
            <outputdir> </outputdir>
            <testdir> </testdir>
            <tableHeader> </tableHeader>
            <outputWithDate>false</outputWithDate>
            <headerDelimited>	</headerDelimited>
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
            <incomingFields> streamtype,streamname,identifier,campaignid,campaigncontext,occuredon,trackedon,producedon,producer,reason,iscontrolgroup,eligiblecounter,prof_brand,prof_priceplan,prof_region_hlr,prof_device_type,prof_name,prof_email,prop_owner,prop_productgroup,prop_objective,prop_type,prop_category,seg_core,seg_sub_core,seg_other,attr_loc_kecamatan,attr_loc_kabupaten,attr_loc_region,attr_cluster,attr_last_balance,attr_revenue,attr_recharge,filename,filedate</incomingFields>
            <partDelimiter> </partDelimiter>
            <partIndex> </partIndex>
            <rejectedHfs> false</rejectedHfs>
            <sourceFields> </sourceFields>
            <sinkFields> </sinkFields>
            <numSinkPart> </numSinkPart>
            <columnFields> streamtype,streamname,identifier,campaignid,campaigncontext,occuredon,trackedon,producedon,producer,reason,iscontrolgroup,eligiblecounter,prof_brand,prof_priceplan,prof_region_hlr,prof_device_type,prof_name,prof_email,prop_owner,prop_productgroup,prop_objective,prop_type,prop_category,seg_core,seg_sub_core,seg_other,attr_loc_kecamatan,attr_loc_kabupaten,attr_loc_region,attr_cluster,attr_last_balance,attr_revenue,attr_recharge,filename,filedate</columnFields>
            <fieldsType> String,String,String,String,String,String,String,String,String,String,String,Integer,String,String,String,String,String,String,String,String,String,String,String,String,String,String,String,String,String,String,Float,Integer,Integer,String,String</fieldsType>
            <compressionCodec> </compressionCodec>
            <blockSize> Default</blockSize>
            <pageSize> Default</pageSize>
        </ParquetSink>
        <ParquetSource>
            <fields> </fields>
            <path> </path>
            <sinkMode> </sinkMode>
            <label> Parquet Input</label>
             <hfsName> ParquetSource_1510801886713</hfsName>
            <ID> 1510801886713</ID>
            <type> PARQUETSOURCE</type>
            <posx> 80.0</posx>
            <posy> 250.0</posy>
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
            <delimiter> </delimiter>
            <fieldGroupPartition> </fieldGroupPartition>
            <incomingFields> </incomingFields>
            <partDelimiter> </partDelimiter>
            <partIndex> </partIndex>
            <rejectedHfs> false</rejectedHfs>
            <sourceFields> </sourceFields>
            <sinkFields> </sinkFields>
            <numSinkPart> </numSinkPart>
            <columnFields> streamtype,streamname,identifier,campaignid,campaigncontext,occuredon,trackedon,producedon,producer,reason,iscontrolgroup,eligiblecounter,prof_brand,prof_priceplan,prof_region_hlr,prof_device_type,prof_name,prof_email,prop_owner,prop_productgroup,prop_objective,prop_type,prop_category,seg_core,seg_sub_core,seg_other,attr_loc_kecamatan,attr_loc_kabupaten,attr_loc_region,attr_cluster,attr_last_balance,attr_revenue,attr_recharge,filename,filedate</columnFields>
            <fieldsType> String,String,String,String,String,String,String,String,String,String,String,Integer,String,String,String,String,String,String,String,String,String,String,String,String,String,String,String,String,String,String,Float,Integer,Integer,String,String</fieldsType>
        </ParquetSource>
        <Hfs2Pipe>
            <fromID> 1510801886713</fromID>
            <toID> 1511249669474</toID>
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
            <jobConf> solusi247.parquet.blockSize,512;mapreduce.job.queuename,root.hsi_nat.hsi_nat_small;mapreduce.map.java.opts,-Xmx200m;mapred.reduce.tasks,5;mapreduce.reduce.memory.mb,4096;mapreduce.map.memory.mb,4096;mapreduce.reduce.java.opts,-Xmx3600m</jobConf>
            <logLoc> Local</logLoc>
        </FlowProperty>
    </HGrid247>
