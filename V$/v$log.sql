---------------------------------------------------------------------------------
-- modif log systeme
---------------------------------------------------------------------------------
select * from v$log ;
select * from v$logfile ;

alter database add logfile group 4 ('/dbabase/data/CARPDBA/redoa/redo-CARPDBA-04a.rdo') size 30M;
alter database add logfile group 5 ('/dbabase/data/CARPDBA/redoa/redo-CARPDBA-05a.rdo') size 30M;

alter system switch logfile ;
alter system checkpoint ;

alter database drop logfile group 5 ;

alter database add logfile group 1 (
'/dbalogs/CARPDBA/redoa/redo-CARPDBA-01a.rdo',
'/dbalogs/CARPDBA/redob/redo-CARPDBA-01b.rdo') size 200M;
 
alter database add logfile group 2 (
'/dbalogs/CARPDBA/redoa/redo-CARPDBA-02a.rdo',
'/dbalogs/CARPDBA/redob/redo-CARPDBA-02b.rdo') size 200M;

alter database add logfile group 3 (
'/dbalogs/CARPDBA/redoa/redo-CARPDBA-03a.rdo',
'/dbalogs/CARPDBA/redob/redo-CARPDBA-03b.rdo') size 200M;

select * from v$log ;

select * from v$logfile ;

alter database add logfile group 4 ('/oralogs/CARPF/redoa/redo-CARPF-04a.rdo') size 30M;

alter database add logfile group 5 ('/oralogs/CARPF/redoa/redo-CARPF-05a.rdo') size 30M;

alter system switch logfile ; 

alter system checkpoint ; 

alter database drop logfile group 5 ; 

alter database add logfile group 1 (
'/oralogs/CARPF/redoa/redo-CARPF-01a.rdo',
'/oralogs/CARPF/redob/redo-CARPF-01b.rdo') size 200M;

alter database add logfile group 2 (
'/oralogs/CARPF/redoa/redo-CARPF-02a.rdo',
'/oralogs/CARPF/redob/redo-CARPF-02b.rdo') size 200M;

alter database add logfile group 3 (
'/oralogs/CARPF/redoa/redo-CARPF-03a.rdo',
'/oralogs/CARPF/redob/redo-CARPF-03b.rdo') size 200M;