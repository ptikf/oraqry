select 
t.begin_interval_time,
res.* from  (
SELECT snap_id,dbid,instance_number inst
       , max(case resource_name when 'processes' then current_utilization end) AS processes
       , max(case resource_name when 'sessions' then current_utilization end) AS sessions
       , max(case resource_name when 'enqueue_locks' then current_utilization end) AS enqueues
--       , max(case resource_name when 'max_rollback_segments' then current_utilization end) AS max_rollback_segments
--       , max(case resource_name when 'parallel_max_servers' then current_utilization end) AS parallel_max_servers
       , max(case resource_name when 'gcs_resources' then current_utilization end) AS gcs_resources
       , max(case resource_name when 'gcs_shadows' then current_utilization end) AS gcs_shadows
       , max(case resource_name when 'ges_procs' then current_utilization end) AS ges_procs
       , max(case resource_name when 'ges_rsv_msgs' then current_utilization end) AS ges_rsv_msgs
    FROM dba_hist_resource_limit res where dbid = 601016237 and instance_number = 1
    group by snap_id,dbid,instance_number ) res    
left outer join dba_hist_snapshot t on res.dbid=t.dbid and t.instance_number=res.inst and t.snap_id=res.snap_id
where 
t.begin_interval_time >= to_date('01/01/2013 00:00','DD/MM/YYYY HH24:MI')
--and  processes > 200
order by t.begin_interval_time ;

select 
t.snap_id,
t.begin_interval_time,
res.instance_number inst,
res.resource_name,
res.current_utilization,
res.max_utilization,
res.initial_allocation,
res.limit_value
from dba_hist_resource_limit res
left outer join dba_hist_snapshot T on t.snap_id=res.snap_id and t.instance_number=res.instance_number and t.dbid=res.dbid
where res.dbid = 601016237
-- and category = 'Other' 
and t.instance_number=1
-- and t.snap_id between 89157 and 89173
-- and res.resource_name  = 'processes'
-- and res.current_utilization > 250
and t.begin_interval_time > to_date('02/04/2013 06:00','DD/MM/YYYY HH24:MI') 
and t.begin_interval_time < to_date('02/04/2013 09:00','DD/MM/YYYY HH24:MI')
order by t.snap_id desc,t.instance_number ; 