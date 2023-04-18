--
-- mbytes par dblink
select trunc(end_interval_time),sum(mbytes) from (
with t as (
select 
snap_id,
sum(value) val
from 
dba_hist_sysstat  sy 
where stat_name= 'bytes received via SQL*Net from dblink' group by sy.snap_id )
select 
end_interval_time,
round((val - Lag (val) OVER(  ORDER BY end_interval_time ))/1024/1024) mbytes
from 
t  inner join 
dba_hist_snapshot s
on t.snap_id=s.snap_id 
where s.instance_number=1 )
group by trunc(end_interval_time)
order by trunc(end_interval_time) desc 
;