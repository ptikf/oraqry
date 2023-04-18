-- Fixed stats
exec DBMS_STATS.CREATE_STAT_TABLE('sys','tablestat');
EXEC DBMS_STATS.GATHER_FIXED_OBJECTS_STATS ('tablestat');

EXEC DBMS_STATS.GATHER_DICTIONARY_STATS(
'SYS',
OPTIONS=>'GATHER', 
ESTIMATE_PERCENT  => DBMS_STATS.AUTO_SAMPLE_SIZE, 
METHOD_OPT => 'FOR ALL COLUMNS SIZE AUTO', 
CASCADE => TRUE);

select dbms_stats.get_param('granularity') from dual
select dbms_stats.get_param('degree') from dual
