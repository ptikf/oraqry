select 
nvl(S.USERNAME,'Internal') usr,L.SID, 
s.seconds_in_wait wt_sec,
s.blocking_session blkses,
block blk,
request rq,
command cmd,
decode(s.type,'BACKGROUND','BACK','USER','USER','????') typ,
au.name ,
l.lmode  ||' '||decode(L.LMODE  ,1,'NULL',2,'ROW-S(SS)',3,'ROW-X(SX)',4,'SHARE(S)',5,'S/ROW-X(SSX)',6,'EXCLUSIVE','None') lmode,
l.request||' '||decode(L.REQUEST,1,'NULL',2,'ROW-S(SS)',3,'ROW-X(SX)',4,'SHARE(S)',5,'S/ROW-X(SSX)',6,'EXCLUSIVE','None') req, 
l.id1||'-'||l.id2 Laddr, 
l.type ltyp,
-- lt.name lname, lt.description
-- decode(command,0,'None',decode(l.id2,0,s.username||'.'||substr(obj.object_NAME,1,20),'None')) object,
decode(l.id2,0,s.username||'.'||substr(obj.object_NAME,1,20),'None') object,
s.sql_id,
vsql.sql_text,
s.prev_sql_id,
vsqlp.sql_text prev_sql_text,
s.module,
s.action
from  v$lock l 
inner join v$session    s on L.SID = S.SID 
inner join v$lock_type lt on l.TYPE=lt.type
left outer join dba_objects obj on obj.object_id = decode(L.ID2,0,L.ID1,1)   
left outer join audit_actions au on S.command=au.action
left outer join v$sqlarea vsql   on vsql .sql_id = s.sql_id 
left outer join v$sqlarea vsqlp  on vsqlp.sql_id = s.prev_sql_id   
where 
S.TYPE != 'BACKGROUND' 
and l.type not in ('AE','MR');
