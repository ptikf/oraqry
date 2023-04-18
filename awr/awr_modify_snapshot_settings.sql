exec DBMS_WORKLOAD_REPOSITORY.MODIFY_SNAPSHOT_SETTINGS( 60 * 24 * 31,15);

--Le premier paramètre est la durée de rétention en minutes, ici: 60 minutes * 24 heures * 31 jours
-- le deuxième paramètre est l'intervalle, ici 15 minutes.

exec DBMS_WORKLOAD_REPOSITORY.modify_baseline_window_size(window_size =>1 );

select 
extract( day    from snap_interval) *24*60+
extract( hour   from snap_interval) *60+
extract( minute from snap_interval) snapshot_interval,
extract( day from retention   ) *24*60+
extract( hour from retention  ) *60+
extract( minute from retention) retention_interval,
topnsql
from dba_hist_wr_control;

select * from dba_hist_database_instance ;

select * from dba_hist_snapshot ;
