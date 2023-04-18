 set lines 255 pages 1000
set define on 
define wsql_id = 'c4xj0ds82pmj2' 
define wchild_no = '0'
define wformat = 'allstats last advanced' 

with 
sql_plan_data as ( select  id, parent_id from    gv$sql_plan where   inst_id = sys_context('userenv','instance') and sql_id = '&wsql_id'  and child_number = to_number('&wchild_no') ),
hierarchy_data as (  select  id, parent_id from    sql_plan_data start   with id = 0 connect by prior id = parent_id order siblings by id desc ),
ordered_hierarchy_data as (  select id,parent_id as pid,row_number() over (order by rownum desc) as oid , max(id) over () as maxid  from   hierarchy_data),
xplan_data as (
        select rownum as r ,x.plan_table_output as plan_table_output ,o.id ,o.pid , o.oid ,o.maxid,count(*) over () as rc
        from   table(dbms_xplan.display_cursor('&wsql_id',to_number('&wchild_no'),'&wformat')) x
               left outer join ordered_hierarchy_data o
               on (o.id = case when regexp_like(x.plan_table_output, '^\|[\* 0-9]+\|') then to_number(regexp_substr(x.plan_table_output, '[0-9]+')) end) )
select plan_table_output
from   xplan_data model
   dimension by (rownum as r)
   measures (plan_table_output,id,maxid,pid,oid,
             greatest(max(length(maxid)) over () + 3, 6) as csize,
             cast(null as varchar2(128)) as inject, rc)
   rules sequential order (
          inject[r] = case
                when id[cv()+1] = 0 or id[cv()+3] = 0 or   id[cv()-1] = maxid[cv()-1] then rpad('-', csize[cv()]*2, '-')
                when id[cv()+2] = 0                         then '|' || lpad('Pid |', csize[cv()]) || lpad('Ord |', csize[cv()])
                when id[cv()] is not null                   then '|' || lpad(pid[cv()] || ' |', csize[cv()]) || lpad(oid[cv()] || ' |', csize[cv()]) 
                end, 
          plan_table_output[r] = case
                when inject[cv()] like '---%' then inject[cv()] || plan_table_output[cv()]
                when inject[cv()] is not null then regexp_replace(plan_table_output[cv()], '\|', inject[cv()], 1, 2)
                                         else plan_table_output[cv()]
                end ||
                                 case when cv(r) = rc[cv()] then  chr(10)
                end     ) order  by r;
