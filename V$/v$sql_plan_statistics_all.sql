select 
INST_ID
,ADDRESS                     RAW(8 BYTE)    
,HASH_VALUE                  NUMBER         
,SQL_ID                      VARCHAR2(13)   
,PLAN_HASH_VALUE             NUMBER         
,CHILD_ADDRESS               RAW(8 BYTE)    
,CHILD_NUMBER                NUMBER         
,TIMESTAMP                   DATE           
,OPERATION                   VARCHAR2(120)  
,OPTIONS                     VARCHAR2(120)  
,OBJECT_NODE                 VARCHAR2(160)  
,OBJECT#                     NUMBER         
,OBJECT_OWNER                VARCHAR2(30)   
,OBJECT_NAME                 VARCHAR2(30)   
,OBJECT_ALIAS                VARCHAR2(65)   
,OBJECT_TYPE                 VARCHAR2(80)   
,OPTIMIZER                   VARCHAR2(80)   
,ID                          NUMBER         
,PARENT_ID                   NUMBER         
,DEPTH                       NUMBER         
,POSITION                    NUMBER         
,SEARCH_COLUMNS              NUMBER         
,COST                        NUMBER         
,CARDINALITY                 NUMBER         
,BYTES                       NUMBER         
,OTHER_TAG                   VARCHAR2(140)  
,PARTITION_START             VARCHAR2(256)  
,PARTITION_STOP              VARCHAR2(256)  
,PARTITION_ID                NUMBER         
,OTHER                       VARCHAR2(4000) 
,DISTRIBUTION                VARCHAR2(80)   
,CPU_COST                    NUMBER         
,IO_COST                     NUMBER         
,TEMP_SPACE                  NUMBER         
,ACCESS_PREDICATES           VARCHAR2(4000) 
,FILTER_PREDICATES           VARCHAR2(4000) 
,PROJECTION                  VARCHAR2(4000) 
,TIME                        NUMBER         
,QBLOCK_NAME                 VARCHAR2(30)   
,REMARKS                     VARCHAR2(4000) 
,OTHER_XML                   CLOB           
,EXECUTIONS                  NUMBER         
,LAST_STARTS                 NUMBER         
,STARTS                      NUMBER         
,LAST_OUTPUT_ROWS            NUMBER         
,OUTPUT_ROWS                 NUMBER         
,LAST_CR_BUFFER_GETS         NUMBER         
,CR_BUFFER_GETS              NUMBER         
,LAST_CU_BUFFER_GETS         NUMBER         
,CU_BUFFER_GETS              NUMBER         
,LAST_DISK_READS             NUMBER         
,DISK_READS                  NUMBER         
,LAST_DISK_WRITES            NUMBER         
,DISK_WRITES                 NUMBER         
,LAST_ELAPSED_TIME           NUMBER         
,ELAPSED_TIME                NUMBER         
,POLICY                      VARCHAR2(40)   
,ESTIMATED_OPTIMAL_SIZE      NUMBER         
,ESTIMATED_ONEPASS_SIZE      NUMBER         
,LAST_MEMORY_USED            NUMBER         
,LAST_EXECUTION              VARCHAR2(40)   
,LAST_DEGREE                 NUMBER         
,TOTAL_EXECUTIONS            NUMBER         
,OPTIMAL_EXECUTIONS          NUMBER         
,ONEPASS_EXECUTIONS          NUMBER         
,MULTIPASSES_EXECUTIONS      NUMBER         
,ACTIVE_TIME                 NUMBER         
,MAX_TEMPSEG_SIZE            NUMBER         
,LAST_TEMPSEG_SIZE           NUMBER
from gv$sql_plan_statistics_all s where s.sql_id = 'dc4rf4k2ag4bu' ;

  SELECT   ID
          ,PARENT_ID
          ,DEPTH
          ,POSITION
          ,LPAD(' ', 2 * DEPTH) || operation operation
          ,options
          ,object_name
          ,last_starts
          ,CARDINALITY "EST ROWS"
          ,last_output_rows "ACTUAL ROWS"
          ,last_output_rows  - last_starts "ACTUAL ROWS PER OP"
    FROM      gv$sql_plan_statistics_all where sql_id = 'dc4rf4k2ag4bu' 
ORDER BY   id;

