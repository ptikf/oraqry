select 
a.sid, 
a.username, 
b.xidusn, 
b.used_urec, 
b.used_ublk
from 
v$session a, 
v$transaction b
where a.saddr=b.ses_addr;

SELECT s.osuser
, p.spid 
, s.BLOCKING_SESSION 
, s.SID
, s.SERIAL#
, s.USERNAME
, s.MACHINE
, q.SQL_FULLTEXT cur_sql
, qa.SQL_FULLTEXT prev_sql
, vt.used_urec, vt.start_date
FROM 
   v$session s LEFT JOIN v$sqlarea q ON s.SQL_ID = q.SQL_ID
   LEFT JOIN v$sqlarea qa ON s.PREV_SQL_ID = qa.SQL_ID
   LEFT JOIN v$process p ON s.paddr = p.addr
   RIGHT JOIN v$transaction vt ON s.saddr = vt.ses_addr