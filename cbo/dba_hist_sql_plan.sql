  col id format A4
  col parent format a4
  col oper format A150
  with p as (select * from DBA_HIST_SQL_PLAN where sql_id ='0wax2tbjh3ysb'
        and operation not like '%PX%' )
SELECT /*+ no_merge */
      id,
      parent_id parent,
      LPAD(' ',depth)||' '||OPERATION oper,
      OPTIONS,
      OBJECT_NAME  object_name,
      cardinality card,
      cost,
      substr(access_predicates,1,30) accessp,
      substr(filter_predicates,1,30) filterp,
      substr(projection,1,30) proj ,      
      other_tag
FROM
       p
WHERE
        sql_id='0wax2tbjh3ysb'
        and operation not like '%PX%' 
    -- and DBID=&DBID
order by  ID,PLAN_HASH_VALUE;