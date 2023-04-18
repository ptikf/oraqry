select 
sample_time,
session_id  as sid,
session_serial# as serial#,
user_id as usid,
sql_id,
sql_child_number as sql_child,
sql_plan_hash_value as sqlphash,
-- force_matching_signature,
sql_opcode ,
service_hash as sash,
session_type,
session_state as state ,
-- qc_session_id,
-- qc_instance_id,
blocking_session as block_sid,
blocking_session_status as block_sid_status,
blocking_session_serial#,
event,
event_id,
seq#,
p1text,
p1,
p2text,
p2,
p3text,
p3,
wait_class,
wait_class_id,
wait_time,
time_waited,
xid,
current_obj#,
current_file#,
current_block#,
program,
module,
action,
client_id,
flags
from dba_hist_active_sess_history 
where event like 'enq: TM%' ;


select 
distinct ash.sql_id,
dbms_lob.SUBSTR(ds.sql_text,100,1)
from 
dba_hist_active_sess_history ash
left outer join dba_hist_sqltext ds on ash.sql_id= ds.sql_id  
where event like 'enq: TM%' 
;
