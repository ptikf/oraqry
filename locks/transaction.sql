-- https://orastory.wordpress.com/2018/01/20/blocking-prepared-xa-transaction/

select s.machine
,      lo.inst_id
,      lo.object_id
,      lo.session_id
,      lo.os_user_name
,      lo.process
,      ob.owner
,      ob.object_name
,      ob.subobject_name
,      tx.addr
,      tx.start_time txn_start_time
,      tx.status
,      tx.xid
,      s.*
from   gv$locked_object lo
,      dba_objects      ob
,      gv$transaction    tx
,      gv$session        s
where  ob.object_id = lo.object_id
and    tx.xidusn    (+) = lo.xidusn
and    tx.xidslot   (+) = lo.xidslot
and    tx.xidsqn    (+) = lo.xidsqn
and    s.taddr      (+) = tx.addr
order by txn_start_time, session_id, object_name;

select 
count(*) over (partition by h.sample_time) sess_cnt
,      h.user_id
,      (select username from dba_users u where u.user_id = h.user_id) u, h.service_hash
,      xid
, sample_id
, sample_time, session_state, session_id, session_serial#
, sql_id
, sql_exec_id, sql_exec_start, event
, p1
, mod(p1,16), blocking_session,blocking_session_serial#
, current_obj#
,      (select object_name||' - '||subobject_name from dba_objects where object_id = current_obj#) obj
,      (select sql_fulltext from v$sql s where s.sql_id = h.sql_id and rownum = 1) sqltxt
,      (select sql_text from dba_hist_sqltext s where s.sql_id = h.sql_id and rownum = 1) sqltxt
, h.*
from   v$active_session_history h
where event = 'enq: TX - row lock contention'
order by h.sample_id desc;

select state
,      UTL_RAW.CAST_TO_BINARY_INTEGER (globalid)
,      UTL_RAW.CAST_TO_BINARY_INTEGER (branchid)
,      t.* 
from v$global_transaction t where state = 'COLLECTING';