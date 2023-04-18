select 
ses.SID,
ses.USERNAME,
-- ses.OSUSER, ses.TERMINAL,
DECODE(l.ID2, 0, obj.OBJECT_NAME, 'Trans-'||to_char(l.ID1)) OBJECT_NAME,  
l.TYPE,
DECODE(l.LMODE,  1,'Null',2,'Row Share',3,'Row Excl',4,'Share',5,'Sha Row Exc',6,'Exclusive','None') "Lock Mode",
DECODE(l.REQUEST,1,'Null',2,'Row Share',3,'Row Excl',4,'Share',5,'Sha Row Exc',6,'Exclusive','None') "Req Mode",
ses.seconds_in_wait wt_secs,                     
ses.sql_id, sql.sql_text                        
from 
v$session ses 
left outer join v$sql sql on ses.sql_id=sql.sql_id
left outer join v$lock l on l.sid = ses.sid
left outer join dba_objects obj on l.id1=obj.object_id
where ses.type <> 'BACKGROUND' 
;