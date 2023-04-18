EXECUTE DBMS_MONITOR.SESSION_TRACE_ENABLE(session_id => 133, serial_num => 1337,waits => TRUE, binds => TRUE);

EXECUTE DBMS_MONITOR.SESSION_TRACE_DISABLE(session_id => 133, serial_num => 1337);

ALTER SESSION SET TRACEFILE_IDENTIFIER = 'my_trace_id';

tkprof fic.trc fic.tkp sort=exeela explain=ritmxbo/ritmxbo