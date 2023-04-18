select 
-- lo.xidusn,lo.xidslot,lo.xidsqn,lo.object_id,lo.session_id,,
lo.oracle_username,lo.os_user_name,locked_mode,
DECODE(lo.locked_MODE,  1,'Null',2,'Row Share',3,'Row Excl',4,'Share',5,'Sha Row Exc',6,'Exclusive','None') "Lock Mode",
obj.object_id,obj.owner,obj.object_name,obj.object_type,
ses.sid,
ses.serial#,
ses.sql_id,
ses.status,
-- lck.*,
lck.type,
lck.id1,
lck.id2,
lck.lmode,
DECODE(lck.lmode, 1,'Null',2,'Row Share',3,'Row Excl',4,'Share',5,'Sha Row Exc',6,'Exclusive','None') "LMode",
lck.request,
DECODE(lck.request, 1,'Null',2,'Row Share',3,'Row Excl',4,'Share',5,'Sha Row Exc',6,'Exclusive','None') "Req",
lck.ctime,
lck.block,
sql.sql_text
from v$locked_object lo 
left outer join all_objects obj on lo.object_id=obj.object_id 
left outer join v$session ses on lo.SESSION_ID=ses.sid 
left outer join v$sql sql on ses.sql_id = sql.sql_id 
left outer join v$lock lck on lo.session_id=lck.sid 
;