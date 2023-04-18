SELECT   /*+ choose */ 
         bs.username "Blocking User", 
         bs.username "DB User", 
         ws.username "Waiting User", 
         bs.sid "SID", 
         ws.sid "WSID", 
         bs.sql_address "address", 
         bs.sql_hash_value "Sql hash", 
         bs.program "Blocking App", 
         ws.program "Waiting App", 
         bs.machine "Blocking Machine", 
         ws.machine "Waiting Machine", 
         bs.osuser "Blocking OS User", 
         ws.osuser "Waiting OS User", 
         bs.serial# "Serial#", 
         DECODE ( 
            wk.TYPE, 
            'MR', 'Media Recovery', 
            'RT', 'Redo Thread', 
            'UN', 'USER Name', 
            'TX', 'Transaction', 
            'TM', 'DML', 
            'UL', 'PL/SQL USER LOCK', 
            'DX', 'Distributed Xaction', 
            'CF', 'Control FILE', 
            'IS', 'Instance State', 
            'FS', 'FILE SET', 
            'IR', 'Instance Recovery', 
            'ST', 'Disk SPACE Transaction', 
            'TS', 'Temp Segment', 
            'IV', 'Library Cache Invalidation', 
            'LS', 'LOG START OR Switch', 
            'RW', 'ROW Wait', 
            'SQ', 'Sequence Number', 
            'TE', 'Extend TABLE', 
            'TT', 'Temp TABLE', 
            wk.TYPE 
         ) lock_type, 
         DECODE ( 
            hk.lmode, 
            0, 'None', 
            1, 'NULL', 
            2, 'ROW-S (SS)', 
            3, 'ROW-X (SX)', 
            4, 'SHARE', 
            5, 'S/ROW-X (SSX)', 
            6, 'EXCLUSIVE', 
            TO_CHAR (hk.lmode) 
         ) mode_held, 
         DECODE ( 
            wk.request, 
            0, 'None', 
            1, 'NULL', 
            2, 'ROW-S (SS)', 
            3, 'ROW-X (SX)', 
            4, 'SHARE', 
            5, 'S/ROW-X (SSX)', 
            6, 'EXCLUSIVE', 
            TO_CHAR (wk.request) 
         ) mode_requested, 
       object_name , 
         TO_CHAR (hk.id1) lock_id1, 
         TO_CHAR (hk.id2) lock_id2 
FROM     v$lock hk, v$session bs, v$lock wk, v$session ws ,  V$LOCKED_OBJECT a , 
dba_objects b 
WHERE    hk.BLOCK = 1 
AND      hk.lmode != 0 
AND      hk.lmode != 1 
AND      wk.request != 0 
AND      wk.TYPE(+) = hk.TYPE 
AND      wk.id1(+) = hk.id1 
AND      wk.id2(+) = hk.id2 
AND      hk.sid = bs.sid(+) 
AND      wk.sid = ws.sid(+) 
AND      a.object_id=b.object_id 
AND      hk.sid=a.session_id 
ORDER BY 1;
----------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------
SELECT session_id , oracle_username , os_user_name
  FROM V$LOCKED_OBJECT VLO INNER JOIN dba_objects DO ON VLO.object_id = DO.object_id
 WHERE object_name = 'object_name'
   AND owner = 'owner';
----------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------
select
   c.owner,
   c.object_name,
   c.object_type,
   b.sid,
   b.serial#,
   b.status,
   b.osuser,
   b.machine
from
   v$locked_object a ,
   v$session b,
   dba_objects c
where   b.sid = a.session_id
and   a.object_id = c.object_id;
----------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------
select
         (select osuser from v$session where sid=a.sid) blocker,
      a.sid,
  (select serial# from v$session where sid=a.sid) serial#,
   ' blocks ',
       (select osuser from v$session where sid=b.sid) blockee,
         b.sid, c.username username
  from v$lock a, v$lock b, v$session c
 where a.block = 1
   and b.request > 0
   and a.id1 = b.id1
   and a.id2 = b.id2
   and b.sid = c.sid
----------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------
SELECT 
  s.sid "SID", 
  s.serial# "SER", 
  o.object_name "Table", 
  o.owner, 
  s.osuser "OS User", 
  s.machine "Node", 
  s.terminal "Terminal", 
  --p.spid "SPID", 
  --s.process "CPID", 
  decode (s.lockwait, NULL, 'Have Lock(s)', 'Waiting for <' || b.sid || '>') "Mode", 
  substr (c.sql_text, 1, 150) "SQL Text" 
FROM v$lock l, 
  v$lock d, 
  v$session s, 
  v$session b, 
  v$process p, 
  v$transaction t, 
  sys.dba_objects o, 
  v$open_cursor c 
WHERE l.sid = s.sid 
  AND o.object_id (+) = l.id1 
  AND c.hash_value (+) = s.sql_hash_value 
  AND c.address (+) = s.sql_address 
  AND s.paddr = p.addr 
  AND d.kaddr (+) = s.lockwait 
  AND d.id2 = t.xidsqn (+) 
  AND b.taddr (+) = t.addr 
  AND l.type = 'TM' 
GROUP BY 
  o.object_name, 
  o.owner, 
  s.osuser, 
  s.machine, 
  s.terminal, 
  p.spid, 
  s.process, 
  s.sid, 
  s.serial#, 
  decode (s.lockwait, NULL, 'Have Lock(s)', 'Waiting for <' || b.sid || '>'), 
  substr (c.sql_text, 1, 150) 
ORDER BY 
  decode (s.lockwait, NULL, 'Have Lock(s)', 'Waiting for <' || b.sid || '>') DESC, 
  o.object_name ASC, 
  s.sid ASC; 
----------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------- 



