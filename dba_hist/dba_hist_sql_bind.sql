select 
snap_id snap,
sql_id,
NAME,
POSITION pos,
-- dup_position,
-- datatype,
datatype_string,
-- character_sid,
-- PRECISION,
-- scale,
max_length length,
was_captured captured ,
last_captured,
value_string,
value_anydata anydata
from dba_hist_sqlbind
where sql_id = '2vphj86sbnwbg' 
and snap_id > 11275
--  and position  = 3
-- in (4,5,6)
order by
-- value_string  
-- snap_id desc,
last_captured desc,
 pos
   ; 
   
select 
to_char(begin_interval_time,'DD/MM/YY HH24:MI:SS') stime,
sb.snap_id snap,
sb.sql_id,
sb.name,
sb.position pos, 
dup_position dup,
-- datatype datat,
datatype_string dtype_string,
character_sid char_sid,
precision pres,
scale scl,
max_length maxl,
was_captured captured,
last_captured,
value_string v_string,
value_anydata val
from 
dba_hist_sqlbind sb,
dba_hist_snapshot s
where 
sb.snap_id=s.snap_id 
and sql_id =  'bs1rgpp313g0z'
and begin_interval_time >= to_date('06/09/2010 01:30','dd/mm/yyyy HH24:MI:SS')
order by stime asc  
;   