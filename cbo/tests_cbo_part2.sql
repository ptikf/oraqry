drop table T1;
create table t1 (c VARCHAR2(1), J number) ;
truncate table T1 ; 
insert into t1 values ('A',1);
insert into t1 values ('A',2);
insert into t1 values ('B',3);
insert into t1 values ('B',4);
insert into t1 values ('B',5);
insert into t1 values ('B',6);
insert into t1 values ('C',7);
insert into t1 values ('C',8);
insert into t1 values ('C',9);
insert into t1 values ('D',0);

drop table T2;
create table T2 (J number) ;
truncate table T2 ; 
insert into t2 values (1);
insert into t2 values (2);
insert into t2 values (3);
insert into t2 values (4);
insert into t2 values (5);
insert into t2 values (6);
insert into t2 values (7);
insert into t2 values (8);
insert into t2 values (9);
insert into t2 values (0);
commit ;

select /*+ gather_plan_statistics */ * from t1 inner join t2 on t1.j=t2.j
and t1.c='D'  
;

select * from table(dbms_xplan.display_cursor(null,null,'allstats last advanced')); 

select * from t1 where c='D' ;

exec    DBMS_STATS.GATHER_TABLE_STATS (
          OwnName          => user
         ,TabName          => 'T1'
         ,estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE
         ,method_opt       => 'FOR ALL  COLUMNS SIZE 3'     
         ,degree           => DBMS_STATS.AUTO_DEGREE 
         ,Cascade          => TRUE
         ,No_Invalidate    => FALSE
         ,Force               => TRUE);

create table T1 as
select
    trunc(dbms_random.value(1,13))    month_no
from
    all_objects
where rownum <= 1200 ;

select * from T1 where month_no = 5 ;

select * from user_tab_col_statistics where table_name = 'T' ; 

select * from user_tab_histograms where table_name = 'T' ;

select month_no,count(*) from t1 
group by month_no 
order by month_no ; 

begin
    dbms_stats.gather_table_stats(
        user,'audience',
        cascade=>true,
        estimate_percent => null,
        method_opt =>'for all columns size 1'
    );
end;
/