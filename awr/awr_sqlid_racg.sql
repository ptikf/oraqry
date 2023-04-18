SELECT *
  FROM TABLE (DBMS_WORKLOAD_REPOSITORY.awr_sql_report_html (99145936,
                                                            1,
                                                            3487,
                                                            3522,
                                                            '6939ymajfgfz9',
                                                            0
                                                           );
													   
														   
define annee = '2017'
define mois = '03'
define jour = '22'
define hdeb = '09:00'
define hfin = '20:00'
define hdeb1 = '0900'
define hfin1 = '2000'

define db='MDMFUT3'
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
                                                           
														   