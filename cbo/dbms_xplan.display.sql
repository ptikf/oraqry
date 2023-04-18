ALTER SESSION SET tracefile_identifier = 'CBO_PART2_1';
ALTER SESSION SET EVENTS '10053 trace name context forever, level 1';
ALTER SESSION SET EVENTS '10053 trace name context off';

set autotrace traceonly explain
alter session set events '10053 trace name context forever, level 1';
alter session set events '10053 trace name context off';
set autotrace off 

select * from table(dbms_xplan.display_cursor('afwwasz8abswg',null,'ALLSTATS LAST ADVANCED'));

SELECT * FROM table(dbms_xplan.display_awr(nvl('&sql_id','a96b61z6vp3un'),nvl('&plan_hash_value',null),null,'typical +peeked_binds'))


select /*+ gather_plan_statistics */ * from dual ;
select * from table(dbms_xplan.display_cursor(null,null,'allstats last advanced')); 


/*
SET AUTOTRACE OFF           - No AUTOTRACE report is generated. This is the
                              default.  
SET AUTOTRACE ON EXPLAIN    - The AUTOTRACE report shows only the optimizer
                              execution path. 
SET AUTOTRACE ON STATISTICS - The AUTOTRACE report shows only the SQL
                              statement execution statistics.  
SET AUTOTRACE ON            - The AUTOTRACE report includes both the
                              optimizer execution path and the SQL
                              statement execution statistics.  
SET AUTOTRACE TRACEONLY     - Like SET AUTOTRACE ON, but suppresses the
                              printing of the user's query output, if any. 
*/