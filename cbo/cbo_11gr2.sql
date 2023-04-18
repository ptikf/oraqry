drop table T ; 
create table T as 
select 1 fk,dbms_random.string('A',80) pad from dual connect by level <=     5 union all 
select 2 fk,dbms_random.string('A',80) pad from dual connect by level <=    50 union all 
select 3 fk,dbms_random.string('A',80) pad from dual connect by level <=   500 union all 
select 4 fk,dbms_random.string('A',80) pad from dual connect by level <=  1000 union all 
select 5 fk,dbms_random.string('A',80) pad from dual connect by level <=200000 ;
select fk,count(*) from t group by fk order by fk ;
create index t_idx_fk on t(fk) ;

drop table t1 ;
create table T1 as select rownum pk,dbms_random.string('A',80) pad from dual   connect by level <=100 ;
create index t1_idx_pk on t1(pk) ;
update t1 set pad='5' where pk=5;
commit ;

exec DBMS_STATS.GATHER_TABLE_STATS(USER,'T' ,estimate_percent=>DBMS_STATS.AUTO_SAMPLE_SIZE,method_opt=>'FOR COLUMNS FK SIZE 5,for columns pad size 1' );

exec DBMS_STATS.GATHER_TABLE_STATS(USER,'T1',estimate_percent=>DBMS_STATS.AUTO_SAMPLE_SIZE,method_opt=>'FOR COLUMNS PK SIZE 254,for columns pad size 254' );

select table_name,num_rows,last_analyzed  from user_tab_statistics where table_name = 'T' ;
select table_name,column_name,num_distinct,
-- low_value,high_value,
density,num_buckets,histogram,last_analyzed from user_tab_col_statistics 
where table_name = 'T1' ;

select count(*) from t1 where pad='5' ;

select count(distinct tp) from (
select /*+ gather_plan_statistics */ t.pad tp,t1.pad from t inner join t1 on t.fk=t1.pk 
where  t1.pad='5' 
order by t.pad,t1.pad);

select * from table(dbms_xplan.display_cursor(null,null,'allstats last'));

select * from ri_proto2007 
where target_table = 'DEPOSITAIRE' ;
