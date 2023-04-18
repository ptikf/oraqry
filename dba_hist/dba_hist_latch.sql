select
count(*),
sql_id,
nvl(o.object_name,ash.current_obj#) objn,
substr(o.object_type,0,10) otype,
CURRENT_FILE# fn,
CURRENT_BLOCK# blockn
from dba_hist_active_sess_history ash
, all_objects o
where event like 'latch: cache buffers chains'
and o.object_id (+)= ash.CURRENT_OBJ#
and snap_id > 13219 
-- and snap_id < 13231
group by sql_id, current_obj#, current_file#,
current_block#, o.object_name,o.object_type
order by count(*)