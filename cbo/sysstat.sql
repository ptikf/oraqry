--
-- Valeurs prod CARPP au 17 Juin 
--
begin
dbms_stats.set_system_stats('IOTFRSPEED',39654.951);
dbms_stats.set_system_stats('IOSEEKTIM',4.596);
dbms_stats.set_system_stats('SREADTIM',0.686);
dbms_stats.set_system_stats('MREADTIM',0.186);
dbms_stats.set_system_stats('CPUSPEED',1818);
dbms_stats.set_system_stats('CPUSPEEDNW',1729.66);
dbms_stats.set_system_stats('MBRC',15);
dbms_stats.set_system_stats('MAXTHR',123904);
--dbms_stats.set_system_stats('SLAVETHR',8);
end;
/

--
-- Valeurs prod Nuit1
--
begin
--dbms_stats.set_system_stats('IOTFRSPEED',39654.951);
--dbms_stats.set_system_stats('IOSEEKTIM',4.596);
dbms_stats.set_system_stats('SREADTIM',9.179);
dbms_stats.set_system_stats('MREADTIM',5.515);
dbms_stats.set_system_stats('CPUSPEED',1659);
--dbms_stats.set_system_stats('CPUSPEEDNW',1729.66);
dbms_stats.set_system_stats('MBRC',16);
dbms_stats.set_system_stats('MAXTHR',264464384);
dbms_stats.set_system_stats('SLAVETHR',220160);
end;
/

--
-- Valeurs test CARPFM
--
SNAME	PNAME	PVAL1	PVAL2
SYSSTATS_INFO	STATUS		COMPLETED
SYSSTATS_INFO	DSTART		06-17-2010 12:20
SYSSTATS_INFO	DSTOP		06-17-2010 13:52
SYSSTATS_INFO	FLAGS	1	
SYSSTATS_MAIN	CPUSPEEDNW	1958.793	
SYSSTATS_MAIN	IOSEEKTIM	10	
SYSSTATS_MAIN	IOTFRSPEED	4096	
SYSSTATS_MAIN	SREADTIM	2.889	
SYSSTATS_MAIN	MREADTIM	4.176	
SYSSTATS_MAIN	CPUSPEED	1814	
SYSSTATS_MAIN	MBRC	16	
SYSSTATS_MAIN	MAXTHR	106347520	
SYSSTATS_MAIN	SLAVETHR		



select * from sys.aux_stats$ ; 

exec dbms_stats.gather_system_stats ('NOWORKLOAD') ;

exec DBMS_STATS.GATHER_SYSTEM_STATS (
gathering_mode => 'STOP',  
stattab => 'test_sys_stat' );

exec dbms_stats.restore_system_stats (to_timestamp('17/06/2010 10:00:00','DD/MM/YYYY HH24:MI:SS') ) ;

execute DBMS_STATS.CREATE_STAT_TABLE (USER,'test_sys_stat');

exec DBMS_STATS.IMPORT_SYSTEM_STATS(stattab => 'test_sys_stat') ;

exec DBMS_STATS.DELETE_SYSTEM_STATS () ;

select * from test_sys_stat ;

-----------------------------------------------------------------
Valeurs MOP CARPFM le 22/06/2010: par defaut
SNAME	PNAME	PVAL1	PVAL2
SYSSTATS_INFO	STATUS		COMPLETED
SYSSTATS_INFO	DSTART		01-04-2010 13:18
SYSSTATS_INFO	DSTOP		01-04-2010 13:18
SYSSTATS_INFO	FLAGS	1	
SYSSTATS_MAIN	CPUSPEEDNW	1954.03587443946	
SYSSTATS_MAIN	IOSEEKTIM	10	
SYSSTATS_MAIN	IOTFRSPEED	4096	
SYSSTATS_MAIN	SREADTIM		
SYSSTATS_MAIN	MREADTIM		
SYSSTATS_MAIN	CPUSPEED		
SYSSTATS_MAIN	MBRC		
SYSSTATS_MAIN	MAXTHR		
SYSSTATS_MAIN	SLAVETHR		
