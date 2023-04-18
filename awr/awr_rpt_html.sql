set heading off;
set linesize 1500;
-- spool 'C:\cardpro\SOCLE\interne\Performances\mesures\ADDM_AWR\TOTAL_production\2010_03\'; 
spool 'C:\_Total\AWR_CARPFM_2010_03_08_1025_1217.html';
SELECT output  FROM TABLE  (DBMS_WORKLOAD_REPOSITORY.awr_report_html( (select dbid from v$database),1,
 (SELECT min(snap_id) -2 from dba_hist_snapshot where begin_interval_time >= to_date('08/03/2010 10:25','DD/MM/YYYY HH24:MI')),
 (SELECT max(snap_id) +1 from dba_hist_snapshot where   end_interval_time <= to_date('08/03/2010 12:17','DD/MM/YYYY HH24:MI'))  ) );
spool off ; 


set serveroutput off 
set verify off 
set heading off;
set linesize 1500;
SELECT *
 FROM TABLE (DBMS_WORKLOAD_REPOSITORY.awr_sql_report_text((select dbid from v$database),1,
(SELECT min(snap_id) -2 from dba_hist_snapshot where begin_interval_time >= to_date('15/07/2010 10:25','DD/MM/YYYY HH24:MI')),
(SELECT max(snap_id) +1 from dba_hist_snapshot where   end_interval_time <= to_date('15/07/2010 12:17','DD/MM/YYYY HH24:MI')),
'1pkjp724ph093', 0) ); 