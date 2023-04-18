select 
-- snap_id snap,
to_char(ash.sample_time,'YYYY/MM/DD HH24:MI:SS') sample_time,
ash.dbid,
ash.instance_number i, 
ash.session_id sid,
ash.session_serial# ser#,
--ash.session_type typ,
ash.user_id usr,
ash.sql_id,
ash.sql_child_number chld,
ash.SQL_PLAN_OPERATION planop,
-- sql_plan_hash_value,
-- force_matching_signature,
-- ash.sql_opcode op,
to_char(ash.SQL_EXEC_START,'YYYY/MM/DD HH24:MI:SS') start,
-- plsql_entry_object_id,
-- plsql_entry_subprogram_id,
-- plsql_object_id,
-- plsql_subprogram_id,
-- service_hash hash,
ash.session_type,
ash.session_state state,
--ash.qc_session_id qc_ses_id,
-- ash.qc_instance_id qc_ins_id,
ash.blocking_session_status blk_ses_st,
ash.BLOCKING_SESSION sid1,
ash.blocking_session_serial# s#,
ash.event,
ash.event_id,
ash.seq#,
ash.p1text,
ash.p1,
ash.p2text,
ash.p3,
ash.wait_class,
-- wait_class_id,
ash.wait_time wtime,
ash.time_waited twaited,
ash.xid xid,
ash.current_obj# obj#,
ash.current_file# f#,
ash.current_block# blk#,
obj.object_name,
dbms_lob.SUBSTR(sqlt.sql_text,100,1),
dbms_lob.getlength(sqlt.sql_text) len,
ash.program,
ash.module,
ash.action,
ash.client_id,
ash.flags
from dba_hist_active_sess_history ash
left outer join dba_hist_seg_stat_obj obj  on ash.current_obj#=obj.obj# and ash.dbid=obj.dbid
left outer join dba_hist_sqltext      sqlt on ash.sql_id = sqlt.sql_id and ash.dbid=sqlt.dbid
where ash.sample_time 
between 
to_date('2011/09/07 12:20:00','YYYY/MM/DD HH24:MI:SS')
and to_date('2011/09/07 15:30:00','YYYY/MM/DD HH24:MI:SS')
-- and ash.session_id = 331 
-- and ash.dbid = 4099106610
-- and ash.dbid = 601016237
-- and ash.event like 'Data file%' 
order by ash.SAMPLE_time  ;

----------------------------------------------
with t as (select 
current_obj# obj ,
sum(wait_time) wtime,
round(sum(time_waited)/1000) twaited 
from dba_hist_active_sess_history 
where sql_id = 'atupqfv5zaapt'
and sample_time >= to_date('05/10/2010 07:00','DD/MM/YYYY HH24:MI')
and sample_time <= to_date('07/10/2010 07:00','DD/MM/YYYY HH24:MI')
and wait_class = 'User I/O'
group by current_obj# ) 
select 
t.obj,
t.twaited,
obj.object_name
from t
left outer join dba_hist_seg_stat_obj obj on t.obj=obj.obj# ;

----------------------------------------------
select 
snap_id snap,
event_id,
event_name,
wait_class_id,
wait_class,
total_waits,
total_timeouts,
time_waited_micro
 from dba_hist_system_event  
where snap_id >= 9872  and snap_id <= 9887 
-- and event_name like '%log%' 
order by 
event_name,
snap_id ;
------------------------------------------------------------------------
select * from dba_hist_sqlstat 
where snap_id >= 9872  and snap_id <= 9887 
order by 
 ccwait_total desc  
-- apwait_total desc  
--  elapsed_time_total desc
-- disk_reads_total  desc 
-- clwait_total  desc
nulls last ; 
--------------------------------------------------------------------------
select distinct sessid   from dba_hist_sessmetric_history 
where snap_id >= 9872  and snap_id <= 9887
;

---------------------------------------------------------------------------------
select * from dba_hist_sys_time_model 
where snap_id >= 9872 order by snap_id ; 

select 
-- snap_id snap,
to_char(sample_time,'DD/MM/YY HH24:MI:SS') sample_time,
session_id sid ,
session_serial# ser#,
-- user_id usrid,
sql_id,
sql_child_number chld,
-- sql_plan_hash_value sqlphashv,
-- force_matching_signature forcemsig,
sql_opcode op,
-- plsql_entry_object_id,
-- plsql_entry_subprogram_id,
-- plsql_object_id,
-- plsql_subprogram_id,
-- service_hash serv_hash,
session_type,
session_state sess_st,
-- qc_session_id,
-- qc_instance_id,
blocking_session bsid,
blocking_session_status bsidst,
-- blocking_session_serial# bsidser#,
event,
event_id,
seq#,
p1text,
p1,
p2text,
p2,
p3text,
p3,
wait_class wclass,
wait_class_id wclassid,
wait_time wtime,
time_waited twaited ,
xid,
current_obj# cur_obj#,
object_name,
-- current_file# cur_file#,
current_block# cur_blk#,
program,
module,
action,
client_id,
flags
 from dba_hist_active_sess_history ash
 left outer join all_objects o on  ash.current_obj#=o.object_id
where 
 sample_time >= to_date('04/06/2010 12:10','DD/MM/YYYY HH24:MI')
-- and xid = '001500220002CE92' 
--  and event like 'enq: TM%' 
--  and sql_id = '5vft1xq6umww6' 
and session_id = 735 
-- and o.object_name = 'SECURISATION_DONNEE_CONDUCT_BK' 
 order by sample_time asc ;
 
 select * from all_objects where object_id = 31783 ; 
 

select 
distinct ash.sql_id,
dbms_lob.SUBSTR(ds.sql_text,100,1)
from 
dba_hist_active_sess_history ash
left outer join dba_hist_sqltext ds on ash.sql_id= ds.sql_id  
where event like 'enq: TM%' 
;
 
select 
-- snap_id snap,
to_char(sample_time,'DD/MM/YY HH24:MI:SS') sample_time,
session_id sid ,
ash.sql_id,
dbms_lob.SUBSTR(ds.sql_text,300,1)
 from dba_hist_active_sess_history ash 
 left outer join dba_hist_sqltext ds on ash.sql_id = ds.sql_id
where 
-- ash.sql_id = '8c24967cwqm1q' 
-- sample_time >= to_date('08/06/2010 15:30','DD/MM/YYYY HH24:MI')
 session_id = 735   
--    and ash.xid = '001500220002CE92'
--event like 'enq: TM%' 
-- and ash.sql_id not in ('4pgvk2yjqux36')
and sample_time >= to_date('04/06/2010 14:00','DD/MM/YYYY HH24:MI')
   order by sample_time  ;

  
 select sql_id   from dba_hist_active_sess_history 
where 
 sample_time >= to_date('08/06/2010 20:30','DD/MM/YYYY HH24:MI') 
 and event like 'enq: TM%' ;

