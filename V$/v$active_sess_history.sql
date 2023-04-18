select 
-- sample_id, 
to_char(sample_time,'DD/MM/YYYY HH24:MI:SS') smpl_time, 
session_id sid , 
session_serial# ser#, 
-- user_id usid, 
sql_id,
sql_child_number child, 
-- sql_plan_hash_value plan_hash, 
-- force_matching_signature,
sql_opcode opcode, 
-- plsql_entry_object_id,plsql_entry_subprogram_id,plsql_object_id,plsql_subprogram_id, 
-- service_hash, 
session_type,
session_state sess_st, 
-- qc_session_id, qc_instance_id, 
blocking_session blksid,
blocking_session_status blksid_st, 
blocking_session_serial# blksid_ser#, 
event, 
-- event_id,
event#, 
seq#, 
p1text, p1, p2text, p2, p3text, p3, 
wait_class,
-- wait_class_id, 
wait_time wtime, 
time_waited twaited, 
xid, 
current_obj# obj#,
obj.object_name ,
-- current_file#, current_block#, 
-- capture_overhead, is_captured, 
program,
module, action, client_id, machine, port, ecid, flags
from 
v$active_session_history vash
left outer join all_objects obj on vash.current_obj# = obj.object_id  
where sample_time between 
to_date('23/05/2017 19:58:10','DD/MM/YYYY HH24:MI:SS') and 
to_date('23/05/2017 20:20:00','DD/MM/YYYY HH24:MI:SS')  
order by sample_time; 

select * from (
	select
		 SQL_ID ,
		 sum(decode(session_state,'ON CPU',1,0)) as CPU,
		 sum(decode(session_state,'WAITING',1,0)) - sum(decode(session_state,'WAITING', decode(wait_class, 'User I/O',1,0),0)) as WAIT,
		 sum(decode(session_state,'WAITING', decode(wait_class, 'User I/O',1,0),0)) as IO,
		 sum(decode(session_state,'ON CPU',1,1)) as TOTAL
	from gv$active_session_history
	where SQL_ID is not NULL
	group by sql_id
	order by sum(decode(session_state,'ON CPU',1,1))   desc
	)
where rownum <11