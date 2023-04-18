select /*+ no_parallel */
-- * 
   ash.inst_id inst,
-- instance_number,
-- ash.sample_id,
ash.sample_time,
ash.session_id sid, session_serial# ser#,
ash.sql_id,
--ash.is_sqlid_current curr,
--ash.sql_child_number childnum ,
ash.sql_opname op_name,
ash.qc_instance_id qc_inst,
ash.qc_session_id qc_sid,
ash.qc_session_serial# qc_ser#,
ash.event,ash.event_id,
-- event#,
ash.p1text,
ash.p1,
ash.p2text,ash.p2,
ash.p3text,ash.p3,
ash.wait_time wtime,
ash.time_waited,
trunc((ash.time_waited/1000/1000) )twait_sec,
ash.session_state,
ash.blocking_session_status blk_ses_st ,ash.blocking_session blksid ,ash.blocking_session_serial# blk_ser# ,ash.blocking_inst_id blk_inst,
-- ash.blocking_hangchain_info,
ash.current_obj# obj#,ash.current_file# file#,ash.current_block# blk#,ash.current_row# row#,
obj.owner,obj.object_name,
sql.sql_text,
ash.xid,
ash.remote_instance#,
-- ash.name_hash,
ash.program,ash.module,ash.action,ash.client_id,ash.machine,
inf.client_version
from 
  -- dba_hist_active_sess_history ash 
   gv$active_session_history ash
 --left outer join gv$sql sql on ash.instance_number=sql.inst_id and ash.sql_id=sql.sql_id
  left outer join gv$sql sql on ash.inst_id=sql.inst_id and ash.sql_id=sql.sql_id
  left outer join all_objects obj on ash.current_obj# = obj.object_id  
  left outer join gv$session_connect_info inf on ash.session_id= inf.sid  and ash.session_serial# = inf.serial#
--   left outer join gv$active_services
where 1=1
-- wait_time > 1000000
--  and wait_time > 0 
 --and time_waited > 0 
-- and event like 'enq%'
    and  event like 'enq%' and time_waited > 1000000
    -- and ash.blocking_session_status = 'GLOBAL' 
 --  and sql_opname <> 'SELECT' 
--  and blocking_session is not null 
-- and blocking_session_status = 'GLOBAL'
-- and ash.action = 'Cleanup optimizer workload information'
--  and blocking_session_status = 'GLOBAL' 
    -- and session_id = 7915
 -- and ash.sql_id = '0yqbgarjpuaft' 
 -- '5678,35416'
--   and  (session_id,session_serial#) in ((1267,58336))
 -- 117	26420
 -- 2338	58092
--   and (session_id=6828  and session_serial# = 42607)
-- '5703,13492'
-- 
-- and obj.object_name = 'TBL_SEQUENCES'
--          and xid = '1300150007540F00'
-- and obj.object_name = 
-- and  sample_time between 
--to_date('09/09/2021 08:00:00','DD/MM/YYYY HH24:MI:SS') and 
--to_date('09/09/2021 10:00:00','DD/MM/YYYY HH24:MI:SS')  
order by ash.sample_time desc   ;
