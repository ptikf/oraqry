select * from (
select snap_id,
    round( sum(decode(wait_class,'User I/O',time_waited_micro) )/1000) user_IO,
    round( sum(decode(wait_class,'System I/O',time_waited_micro) )/1000) sys_IO,
    round( sum(decode(wait_class,'Cluster',time_waited_micro) )/1000) clustering,
    round( sum(decode(wait_class,'Concurrency',time_waited_micro) )/1000) concurr,
    round( sum(decode(wait_class,'Other',time_waited_micro) )/1000) other,
    round( sum(decode(wait_class,'Application',time_waited_micro) )/1000) appli,
    round( sum(decode(wait_class,'Configuration',time_waited_micro) )/1000) config,
    round( sum(decode(wait_class,'Administrative',time_waited_micro) )/1000) admin,
    round( sum(decode(wait_class,'Commit',time_waited_micro) )/1000) commit,
    round( sum(decode(wait_class,'Scheduler',time_waited_micro) )/1000) schedul,
    nvl(round(sum(decode(wait_class,'Network',time_waited_micro) )/1000),0) network
    from dba_hist_bg_event_summary
    where dbid = 4099106610
        group by snap_id )   order by commit  desc nulls last   ;

		
		