ALTER SYSTEM KILL SESSION 'sid,serial#' IMMEDIATE;
ALTER SYSTEM DISCONNECT SESSION 'sid,serial#' IMMEDIATE;


select s.username,
s.sid,
s.serial#,
s.program,
s.username,
s.lockwait,
s.sql_id,
p.spid,
last_call_et,
status
from 
V$SESSION s, V$PROCESS p where 
s.PADDR = p.ADDR and
p.spid=1450044 ;

select s.username,
s.sid,
s.serial#,
s.program,
s.username,
s.lockwait,
s.sql_id,
p.spid,
last_call_et,
status,
sql.sql_text
from 
V$SESSION s, V$PROCESS p
left outer join v$sql sql on sql.sql_id=sql.sql_id  
where 
s.PADDR = p.ADDR and
p.spid=1450044 ;

select 
sid,
serial# ser#,
username,
lockwait lckw,
blocking_session blk_sid,
schemaname,
osuser,
machine,
sql_exec_start,
ses.module,
logon_time,
event,wait_class,
ses.sql_id,
sqlt.sql_text 
 from v$session ses
 left join v$sql sqlt on ses.sql_id=sqlt.sql_id 
where 
type = 'USER' and status = 'ACTIVE' 
and wait_class <> 'Idle'
order by machine  ;