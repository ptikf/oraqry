begin 
dbms_stats.create_stat_table(
'CARP_TEST',
'STATTAB_SCHEMA4757',
'CARP_DATA');
end ;

begin
dbms_stats.export_schema_stats (
'CARP',
'STATTAB_SCHEMA4757',
'CARP',
'CARP_test');
end ; 

begin 
dbms_stats.create_stat_table(
'CARP',
'STATTAB_PTIKF',
'CARP_DATA');
end ;

begin
dbms_stats.export_table_stats (
'CARP',
'TRANSACTION',
null,
'STATTAB_PTIKF',
null,
TRUE,
null);
end ; 

begin
dbms_stats.import_table_stats (
'CARP',
'TRANSACTION_PTIKF',
null,
'STATTAB_PTIKF',
null,
FALSE,
null);
end ;

begin
dbms_stats.import_schema_stats (
'CARP',
'CARP_STATT_SCHEMA',
'CARP',
'CARP',
FALSE,
TRUE);
end ; 

begin
    dbms_stats.delete_table_stats ('CARP','ENTITE_LEGALE',null); 
    DBMS_STATS.GATHER_TABLE_STATS (
          OwnName          => 'CARP'
         ,TabName          => 'ENTITE_LEGALE'
         ,estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE
         ,method_opt       => 'FOR ALL  COLUMNS SIZE AUTO'     
         ,degree           => DBMS_STATS.AUTO_DEGREE 
         ,Cascade          => TRUE
         ,No_Invalidate    => FALSE
		 ,Force			   => TRUE);
end;

exec  dbms_stats.unlock_table_stats ('CARP','CUMUL_FACTURATION'); 

exec 
DBMS_STATS.restore_TABLE_STATS('carp','log_etape_export',
    as_of_timestamp => to_timestamp('02/05/2010 22:00:00','DD/MM/YYYY HH24:MI:SS'),     
    No_Invalidate   => FALSE,
    force           => TRUE );

select table_name,num_rows,blocks,last_analyzed from all_tables where owner= 'CARP' order by last_analyzed desc nulls last ;

select * from user_tab_col_statistics where table_name = 'ROLE_CARDPRO' ; 

select * from user_histograms where table_name = 'ROLE_CARDPRO' ; 

select 
owner,
table_name tname,
column_name cname,
column_id id,
data_type,
num_distinct dstinct,
--dbms_stats.convert_raw_value(low_value),
decode(data_type
,'NUMBER'     ,utl_raw.cast_to_number(low_value)
,'VARCHAR2'   ,utl_raw.cast_to_varchar2(low_value)) low_value,
decode(data_type
,'NUMBER'     ,utl_raw.cast_to_number(high_value)
,'VARCHAR2'   ,utl_raw.cast_to_varchar2(high_value)) high_value,
-- high_value,
density,
num_nulls nulls ,
num_buckets buckets,
last_analyzed,
--sample_size,
histogram 
 from all_tab_cols 
where table_name = 'T1' 
and owner = user 
order by column_id ;

------------------------------------------------------------------------------------------
--
-- stats avec ntile
--
------------------------------------------------------------------------------------------
SELECT   MIN (minbkt), maxbkt,
         SUBSTRB (DUMP (MIN (val), 16, 0, 32), 1, 120) minval,
         SUBSTRB (DUMP (MAX (val), 16, 0, 32), 1, 120) maxval,
         SUM (rep) sumrep, 
		 SUM (repsq) sumrepsq, 
		 MAX (rep) maxrep,
         COUNT (*) bktndv, 
		 SUM (CASE WHEN rep = 1 THEN 1 ELSE 0 END) unqrep
    FROM (SELECT   val, MIN (bkt) minbkt, MAX (bkt) maxbkt, COUNT (val) rep,
                   COUNT (val) * COUNT (val) repsq
              FROM (SELECT SUBSTRB ("ID_CRM_ADRESSE", 1, 32) val,
                           NTILE (254) OVER (ORDER BY NLSSORT(SUBSTRB ("ID_CRM_ADRESSE", 32 ),'NLS_SORT = binary' )) bkt
                      FROM "CARP"."ZE_ENTITE_SOCIALE" t
                     WHERE SUBSTRB ("ID_CRM_ADRESSE", 1, 32) IS NOT NULL)
          GROUP BY val)
GROUP BY maxbkt
ORDER BY maxbkt;
