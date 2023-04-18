select * from table(dbms_stats.diff_table_stats_in_history(
'CARP',
'WRK_ELAB_RLG',
systimestamp,
systimestamp-5,
0 ) ) ;

select * from dba_tab_stats_history 
where owner = 'CARP' 
and table_name = 'ELEMENT_VALORISE' 
order by stats_update_time desc ; 

SELECT ob.owner, ob.object_name, ob.subobject_name, ob.object_type,obj#, savtime, flags, rowcnt, blkcnt, avgrln ,samplesize, analyzetime, cachedblk, cachehit, logicalread
FROM sys.WRI$_OPTSTAT_TAB_HISTORY, dba_objects ob
WHERE owner='CARP'
and object_name='ELEMENT_VALORISE'
and object_type in ('TABLE')
and object_id=obj#
;

/*
WRI$_OPTSTAT_TAB_HISTORY
WRI$_OPTSTAT_IND_HISTORY
WRI$_OPTSTAT_HISTHEAD_HISTORY
WRI$_OPTSTAT_HISTGRM_HISTORY
WRI$_OPTSTAT_OPR
WRI$_OPTSTAT_AUX_HISTORY
*/

select DBMS_STATS.GET_STATS_HISTORY_RETENTION from dual;

execute DBMS_STATS.ALTER_STATS_HISTORY_RETENTION (xx) ;

select DBMS_STATS.GET_STATS_HISTORY_AVAILABILITY from dual;

exec DBMS_STATS.PURGE_STATS(to_timestamp_tz('01-09-2006 00:00:00 Europe/London','DD-MM-YYYY HH24:MI:SS TZR'));

select * from DBA_OPTSTAT_OPERATIONS ;

select * from v$sysaux_occupants  ;