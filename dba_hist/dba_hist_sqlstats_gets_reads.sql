select 
trunc(snap.begin_interval_time) dat,
sum(case when to_number(to_char(snap.begin_interval_time,'hh24')) between 0  and  2 then disk_reads_delta else 0 end ) as hh00_02,
sum(case when to_number(to_char(snap.begin_interval_time,'hh24')) between 3  and  7 then disk_reads_delta else 0 end ) as hh03_08,
sum(case when to_number(to_char(snap.begin_interval_time,'hh24')) between 8  and 17 then disk_reads_delta else 0 end ) as hh08_18,
sum(case when to_number(to_char(snap.begin_interval_time,'hh24')) between 18 and 23 then disk_reads_delta else 0 end ) as hh18_24,
sum(case when module        like '%Batch%'         then stat.disk_reads_delta else 0 end ) RBatch,
sum(case when module        like '%SQL Developer%' then stat.disk_reads_delta else 0 end ) SQLDev,
sum(case when module        like '%JDBC%'          then stat.disk_reads_delta else 0 end ) RJDBC,
sum(case when upper(module) like '%TOAD%'          then stat.disk_reads_delta else 0 end ) RTOAD,
sum(case when module        like 'sqlplus%'        then stat.disk_reads_delta else 0 end ) RSqlplus
from 
dba_hist_sqlstat  stat,
dba_hist_snapshot snap
where stat.snap_id = snap.snap_id 
and snap.begin_interval_time >= to_date('01/11/2010','DD/MM/YYYY')
group by trunc(snap.begin_interval_time) 
order by trunc(snap.begin_interval_time) desc ; 


select sum(stat.disk_reads_delta) from 
dba_hist_sqlstat  stat,
dba_hist_snapshot snap
where stat.snap_id = snap.snap_id 
and snap.begin_interval_time >= to_date('01/11/2010 03:00','DD/MM/YYYY HH24:MI')
and snap.begin_interval_time <= to_date('01/11/2010 07:55','DD/MM/YYYY HH24:MI')
group by trunc(snap.begin_interval_time) ;