													   
define annee = '2017'
define mois_deb = '03'
define mois_fin = '03'
define jour_deb = '22'
define jour_fin = '22'
define hdeb = '09:00'
define hfin = '20:00'
define hdeb1 = '0900'
define hfin1 = '2000'

define db='FRLADMP1'
define dbinst=1
define dbinst_all='1,2'


define sqlid = '60b62w6xc18xf'

define rep='/home/oracle/awr'

set serveroutput off
set verify off
set echo off
set heading off;
set linesize 1500;
--
spool '&rep./&db._sqlid_&sqlid._&annee._&mois._&jour._&hdeb1._&hfin1..html';
SELECT *
  FROM TABLE (DBMS_WORKLOAD_REPOSITORY.awr_sql_report_html ((select dbid from v$database),
                                                            1,
                                                            (SELECT min(snap_id) -1 from dba_hist_snapshot where begin_interval_time >= to_date('&annee/&mois/&jour &hdeb','YYYY/MM/DD HH24:MI')),
                                                            (SELECT max(snap_id) +1 from dba_hist_snapshot where   end_interval_time <= to_date('&annee/&mois/&jour &hfin','YYYY/MM/DD HH24:MI')),
                                                            '&sqlid',
                                                            0
                                                           ));
spool off                                                           
                                                           
														   