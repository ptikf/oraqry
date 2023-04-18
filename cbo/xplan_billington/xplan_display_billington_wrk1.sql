-- Initialise variables 1,2,3 in case they aren't supplied...
-- ----------------------------------------------------------
set termout off
column 1 new_value 1
column 2 new_value 2
column 3 new_value 3
select null as "1",null as "2" ,null as "3" from dual where  1=2;

-- Set the plan table...
-- ---------------------
column plan_table new_value v_xp_plan_table
select nvl('&1', 'PLAN_TABLE') as plan_table from   dual;

-- Finally prepare the inputs to the main Xplan SQL...
-- ---------------------------------------------------
column plan_id  new_value v_xp_plan_id
column stmt_id  new_value v_xp_stmt_id
column format   new_value v_xp_format
select nvl(max(plan_id), -1)                                           as plan_id
,      max(statement_id) keep (dense_rank first order by plan_id desc) as stmt_id
,      nvl(max('&3'), 'typical')                                       as format
from   &v_xp_plan_table
where  id = 0
and    nvl(statement_id, '~') = coalesce('&2', statement_id, '~');

-- Main Xplan SQL...
-- -----------------
set termout on lines 150 pages 1000
col plan_table_output format a150

with 
sql_plan_data      as (select id, parent_id from &v_xp_plan_table where  plan_id = &v_xp_plan_id order  by id ),    
hierarchy_data 	 as (select id, parent_id from    sql_plan_data start   with id = 0 connect by prior id = parent_id order siblings by id desc),    
ord_hierarchy_data as (select id, parent_id as pid
        ,      row_number() over (order by rownum desc) as oid
        ,      max(id) over () as maxid
        from   hierarchy_data        ),    
xplan_data as (
        select /*+ ordered use_nl(o) */
               rownum as r
        ,      x.plan_table_output as plan_table_output
        ,      o.id, o.pid,o.oid,o.maxid,count(*) over () as rc
        from   table(dbms_xplan.display('&v_xp_plan_table','&v_xp_stmt_id','&v_xp_format')) x
               left outer join ord_hierarchy_data o
               on (o.id = case
                             when regexp_like(x.plan_table_output, '^\|[\* 0-9]+\|')
                             then to_number(regexp_substr(x.plan_table_output, '[0-9]+'))
                          end)
        )
select plan_table_output
from   xplan_data
model
   dimension by (rownum as r)
   measures (plan_table_output,
             id,
             maxid,
             pid,
             oid,
             rc,
             greatest(max(length(maxid)) over () + 3, 6) as csize,
             cast(null as varchar2(128)) as inject)
   rules sequential order (
          inject[r] = case
                         when id[cv()+1] = 0 or   id[cv()+3] = 0 or id[cv()-1] = maxid[cv()-1] then rpad('-', csize[cv()]*2, '-')
                         when id[cv()+2] = 0 then '|' || lpad('Pid |', csize[cv()]) || lpad('Ord |', csize[cv()])
                         when id[cv()] is not null then '|' || lpad(pid[cv()] || ' |', csize[cv()]) || lpad(oid[cv()] || ' |', csize[cv()]) 
                      end, 
          plan_table_output[r] = case
                                    when inject[cv()] like '---%'  then inject[cv()] || plan_table_output[cv()]
                                    when inject[cv()] is not null  then regexp_replace(plan_table_output[cv()], '\|', inject[cv()], 1, 2)
                                    else plan_table_output[cv()]
                                 end ||
                                 case when cv(r) = rc[cv()] then  chr(10)  end 
         ) order  by r;
