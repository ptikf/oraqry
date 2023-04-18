SELECT 
s.sid, 
s.serial#, 
s.username, 
u.segment_name, 
count(u.extent_id) "Extent Count", 
t.used_ublk, 
t.used_urec, 
s.program
FROM 
v$session s, 
v$transaction t, 
dba_undo_extents u
WHERE 
s.taddr = t.addr and 
u.segment_name like '_SYSSMU'||t.xidusn||'_%$' and 
u.status = 'ACTIVE'
GROUP BY s.sid, s.serial#, s.username, u.segment_name, t.used_ublk, t.used_urec, s.program
ORDER BY t.used_ublk desc, t.used_urec desc, s.sid, s.serial#, s.username, s.program;

select
used_ublk,
used_urec 
from v$transaction ;

select * from v$session_longops;

alter system set fast_start_parallel_rollback=false scope=memory ;

