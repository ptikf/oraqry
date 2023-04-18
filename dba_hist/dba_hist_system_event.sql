SELECT   btime,
        (time_ms_end - time_ms_beg)  / NULLIF (count_end - count_beg, 0) avg_ms
FROM 
(SELECT TO_CHAR (s.begin_interval_time, 'DD-MON-YY HH24:MI') btime,
        total_waits count_end,
        time_waited_micro / 1000 time_ms_end,
        LAG (e.time_waited_micro / 1000) OVER (PARTITION BY e.event_name ORDER BY s.snap_id) time_ms_beg,
        LAG (e.total_waits) OVER (PARTITION BY e.event_name ORDER BY s.snap_id) count_beg
 FROM dba_hist_system_event e, dba_hist_snapshot s
 WHERE s.snap_id = e.snap_id
 AND e.event_name LIKE 'log file sync%'
 AND begin_interval_time >= TO_DATE ('28/09/2010 12:00', 'DD/MM/YYYY HH24:MI')
     ORDER BY begin_interval_time)
ORDER BY btime;