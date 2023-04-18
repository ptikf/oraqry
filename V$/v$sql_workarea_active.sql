select 
wa.INST_ID i ,
-- SQL_HASH_VALUE,
wa.SQL_ID,
SQL_EXEC_START,
-- SQL_EXEC_ID,
-- WORKAREA_ADDRESS,
wa.OPERATION_TYPE,
wa.OPERATION_ID id,
wa.POLICY,
wa.SID,
QCINST_ID,QCSID,
round(wa.ACTIVE_TIME/100/60) act_mins,
round(wa.WORK_AREA_SIZE/1024/1024) work_mb ,
round(wa.EXPECTED_SIZE/1024/1024) exp_mb,
round(wa.ACTUAL_MEM_USED/1024/1024) act_mb,
round(wa.MAX_MEM_USED/1024/1024) max_mb,
wa.NUMBER_PASSES num_p,
wa.TEMPSEG_SIZE/1024/1024 temp_mb,
ps.operation,
ps.options,
ps.object_node,
ps.object_owner||'.'||ps.object_name,
ps.object_alias,
ps.object_type,
ps.access_predicates
-- TABLESPACE,SEGRFNO#,SEGBLK#
from gv$sql_workarea_active wa
inner join GV$SQL_PLAN_STATISTICS_ALL ps on wa.sql_id=ps.sql_id and wa.inst_id=ps.inst_id and wa.OPERATION_ID=ps.id 
where wa.sql_id = '295q8wmckkrv0' ; 