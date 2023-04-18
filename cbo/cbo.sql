drop  table T1 ;
drop  table T2 ;

create table T1 as select rownum pk, floor(dbms_random.value(0,10)) fk from dual connect by level <= 10000;
create table T2 as select rownum pk, floor(dbms_random.value(0,10)) fk from dual connect by level <= 10000;
insert  into T1    select rownum pk,floor(dbms_random.value(11,13)) fk from dual connect by level <= 100; 
commit ;

select fk,count(*) from T1 group by fk order by fk ;
select fk,count(*) from T2 group by fk order by fk ;

explain plan for 
select * from T1 where fk = 5;

select 1/count(distinct fk) from t1 ;

select * from rnd1 a,rnd2 b where a.fk=b.fk and a.fk=5; 

purge  recyclebin ; 
         
select * from user_tab_col_statistics ;   
select * from user_histograms ;
select * from user_tables ;       
         
exec 
DBMS_STATS.GATHER_TABLE_STATS (
user,'T1',null,
method_opt=>'for all columns size auto') ;

select dbms_stats.get_param('METHOD_OPT') from dual;   

