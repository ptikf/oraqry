select * from DBA_HIST_MEMORY_RESIZE_OPS ;

select 
instance_number inst,
component,
oper_type oper,
start_time,end_time,
round(target_size / 1024 /1024) tgt_M,
oper_mode,
parameter,
round(initial_size/1024/1024) init_M,
round(final_size/1024/1024) fin_M,
round((final_size-initial_size)/1024/1024) delta_M,
status
from DBA_HIST_MEMORY_RESIZE_OPS  where 
dbid =  601016237  and 
start_time >= to_date('31/01/2013 14:00','DD/MM/YYYY HH24:MI') 
and 
instance_number = 1
order by component,start_time,instance_number  ;
