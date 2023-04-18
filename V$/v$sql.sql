select 
--SQL_TEXT ,
--SQL_FULLTEXT ,
SQL_ID  ,
SHARABLE_MEM    shar_mem,
PERSISTENT_MEM  pers_mem,
RUNTIME_MEM     runt_mem,
SORTS            ,
LOADED_VERSIONS  load_v ,
OPEN_VERSIONS    open_v,
USERS_OPENING     ,
FETCHES           ,
EXECUTIONS         execs ,
-- PX_SERVERS_EXECUTIONS  ,
END_OF_FETCH_COUNT   ,
USERS_EXECUTING      ,
LOADS                ,
FIRST_LOAD_TIME      ,
LAST_LOAD_TIME           ,
LAST_ACTIVE_TIME         ,
INVALIDATIONS     invs   ,
PARSE_CALLS          ,
DISK_READS           ,
DIRECT_WRITES        ,
BUFFER_GETS          ,
APPLICATION_WAIT_TIME app_wait_time ,
CONCURRENCY_WAIT_TIME ,
-- CLUSTER_WAIT_TIME     ,
USER_IO_WAIT_TIME     ,
-- PLSQL_EXEC_TIME       ,
-- JAVA_EXEC_TIME        ,
ROWS_PROCESSED        ,
COMMAND_TYPE       cmd   ,
OPTIMIZER_MODE     opt_mode   ,
OPTIMIZER_COST     opt_cost   ,
-- OPTIMIZER_ENV         ,
-- OPTIMIZER_ENV_HASH_VALUE ,
-- PARSING_USER_ID          ,
-- PARSING_SCHEMA_ID        ,
PARSING_SCHEMA_NAME  PARSING_SCHEMA    ,
KEPT_VERSIONS            ,
-- ADDRESS                  ,
TYPE_CHK_HEAP            ,
HASH_VALUE               ,
--OLD_HASH_VALUE           ,
PLAN_HASH_VALUE          ,
CHILD_NUMBER             ,
SERVICE                  ,
--SERVICE_HASH             ,
MODULE                   ,
--MODULE_HASH              ,
ACTION                   ,
--ACTION_HASH              ,
-- SERIALIZABLE_ABORTS      ,
-- OUTLINE_CATEGORY         ,
CPU_TIME                 ,
ELAPSED_TIME             ,
-- OUTLINE_SID              ,
-- CHILD_ADDRESS            ,
SQLTYPE                  ,
-- REMOTE                   ,
OBJECT_STATUS            ,
-- LITERAL_HASH_VALUE       ,
IS_OBSOLETE              ,
IS_BIND_SENSITIVE        ,
IS_BIND_AWARE            ,
IS_SHAREABLE             ,
CHILD_LATCH              ,
-- SQL_PROFILE              ,
-- SQL_PATCH                ,
-- SQL_PLAN_BASELINE        ,
-- PROGRAM_ID               ,
-- PROGRAM_LINE#            ,
-- EXACT_MATCHING_SIGNATURE ,
-- FORCE_MATCHING_SIGNATURE ,

-- BIND_DATA                ,
TYPECHECK_MEM            ,
--IO_CELL_OFFLOAD_ELIGIBLE_BYTES ,
--IO_INTERCONNECT_BYTES          ,
PHYSICAL_READ_REQUESTS         ,
PHYSICAL_READ_BYTES            ,
PHYSICAL_WRITE_REQUESTS        ,
PHYSICAL_WRITE_BYTES           ,
OPTIMIZED_PHY_READ_REQUESTS    ,
LOCKED_TOTAL                   ,
PINNED_TOTAL                   
--IO_CELL_UNCOMPRESSED_BYTES     ,
--IO_CELL_OFFLOAD_RETURNED_BYTES 
from v$sql ; 

select sql_id,count(*) from v$sql 
where parsing_schema_name not in ('SYS,','SYSTEM','SYSMAN,','MDSYS','EXFSYS','APEX_030200','ORACLE_OCM','DBSNMP','WMSYS')
group by sql_id 
order by count(*) desc ;
