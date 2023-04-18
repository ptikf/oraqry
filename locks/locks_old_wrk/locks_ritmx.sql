--
-- Sessions 
-- 
select 
saddr, 
SID, 
serial# ser#, 
-- audsid, 
-- paddr, 
-- user#, 
username, 
command cmd, 
ownerid,
row_wait_obj#,
blocking_session_status blk_sess_status, 
blocking_instance blk_inst, 
blocking_session blk_sess, 
seconds_in_wait,
o.object_name,
-- row_wait_file#, 
s.sql_id, 
s.sql_child_number sql_child, 
row_wait_block#, 
row_wait_row#, 
taddr, 
lockwait, 
s.status, 
-- server, 
-- schema#, 
schemaname sch, 
osuser, 
-- process,
machine, 
-- port, 
terminal, 
program, 
TYPE, 
sql_address, 
-- sql_hash_value,
-- prev_sql_addr, 
-- prev_hash_value, 
-- prev_sql_id,
-- prev_child_number, 
-- plsql_entry_object_id, 
-- plsql_entry_subprogram_id,
-- plsql_object_id, 
-- plsql_subprogram_id, 
s.module, 
-- module_hash, 
s.action,
s.action_hash ahash, 
client_info cli_info, 
-- fixed_table_sequence, 
logon_time,
last_call_et, 
-- pdml_enabled, 
-- failover_type, 
-- failover_method,
-- failed_over, 
-- resource_consumer_group, 
-- pdml_status, 
-- pddl_status,
-- pq_status, 
current_queue_duration curr_q_duration, 
client_identifier cli_identifier,
seq#,
event#, 
event, 
p1text, 
p1, 
p1raw, 
p2text, 
p2, 
p2raw, 
p3text, 
p3, 
p3raw,
wait_class_id, 
wait_class#, 
wait_class, 
wait_time, 
state, 
service_name, 
-- sql_trace, 
-- sql_trace_waits, 
-- sql_trace_binds, 
-- ecid,
dbms_lob.SUBSTR(sqlt.sql_text,100,1)
from 
v$session s
left outer join all_objects o on s.row_wait_obj#=o.object_id 
left outer join v$sql sqlt    on s.sql_id = sqlt.sql_id 
where 
-- osuser 
wait_class not like  ('Idle%')
-- schemaname <> 'SYS'  
;

select 
B.SID,C.USERNAME,C.OSUSER,C.TERMINAL,
DECODE(B.ID2, 0, A.OBJECT_NAME, 'Trans-'||to_char(B.ID1)) OBJECT_NAME,  
B.TYPE,
DECODE(B.LMODE,0,'--Waiting--',
                      1,'Null',
                      2,'Row Share',
                      3,'Row Excl',
                      4,'Share',
                      5,'Sha Row Exc',
           6,'Exclusive','Other') "Lock Mode",
DECODE(B.REQUEST,0,' ',
                      1,'Null',
                      2,'Row Share',
                      3,'Row Excl',
                      4,'Share',
                      5,'Sha Row Exc',
                      6,'Exclusive',
                     'Other') "Req Mode",
c.seconds_in_wait wt_secs,                     
c.sql_id, sqlt.sql_text                        
from DBA_OBJECTS A, V$LOCK B, V$SESSION C ,v$sql sqlt
where A.OBJECT_ID(+) = B.ID1
  and sqlt.sql_id(+) = c.sql_id 
  and B.SID = C.SID
  and C.USERNAME is not null
order by B.SID, B.ID2;