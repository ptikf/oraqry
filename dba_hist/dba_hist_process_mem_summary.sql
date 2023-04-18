select 
t.snap_id,
t.begin_interval_time,
-- mem.*,
mem.instance_number i,
mem.category categ,
mem.num_processes proc,
mem.non_zero_allocs,
mem.used_total,
mem.allocated_total,
round(mem.allocated_avg,2) alloc_avg,
round(mem.allocated_stddev,2) alloc_stddev,
mem.allocated_max,
mem.max_allocated_max
from 
DBA_HIST_PROCESS_MEM_SUMMARY mem
inner join dba_hist_snapshot T on t.snap_id=mem.snap_id and t.instance_number=mem.instance_number and t.dbid=mem.dbid
where mem.dbid = 601016237
-- and category = 'Other' 
-- and category = 'SQL'
and t.begin_interval_time >= to_date('02/04/2013 06:00','DD/MM/YYYY HH24:MI')
and t.begin_interval_time <= to_date('02/04/2013 08:15','DD/MM/YYYY HH24:MI')
and t.instance_number = 1
order by categ,t.snap_id , t.instance_number ;