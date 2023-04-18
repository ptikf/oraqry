select * from (
select
SQL_ID,
sum(CPU_TIME_DELTA),
sum(DISK_READS_DELTA),
count(*)
from
DBA_HIST_SQLSTAT a, dba_hist_snapshot s
where
s.snap_id = a.snap_id and 
s.inst_id=a.inst_id 
and t.begin_interval_time betwwen 
 to_date('27/08/2018 12:00','DD/MM/YYYY HH24:MI')
 and 
 to_date('27/08/2018 19:00','DD/MM/YYYY HH24:MI')
group by SQL_ID
order by sum(CPU_TIME_DELTA) desc);


27/08/2018