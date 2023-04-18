SET ECHO off
REM NAME:    TFSULOCK.SQL
REM USAGE:"@path/TFSULOCK"
REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT ON V$LOCK, V$SESSION
REM ------------------------------------------------------------------------
REM AUTHOR:
REM    Bruce L. Willden, Oracle Costa Rica
REM ------------------------------------------------------------------------
REM PURPOSE:
REM Shows User Lock Information
REM ------------------------------------------------------------------------
REM EXAMPLE:
REM    Sess                    Op Sys                   OBJ NAME or
REM     ID    USERNAME User ID  TERMINAL TRANS_ID          TY Lock Mode   Req Mode
REM    ----    ------------------- -----------  --------------- ----------------------     --  -----------------   --------------
REM       7   SCOTT          usupport  ttyr5        TA                      TM Row Excl
REM       7   SCOTT          usupport  ttyr5        Trans-196623      TX Exclusive
REM       8   SCOTT          usupport  ttyr1        TABLE_CONFIG TM Row Excl
REM       8   SCOTT          usupport  ttyr1        Trans-131099      TX Exclusive
REM      10  SYSTEM       usupport  ttyqe        TABLE_CONFIG TM Row Excl
REM      10  SYSTEM       usupport  ttyqe        Trans-131099      TX --Waiting--     Exclusive
REM      11  SYS              usupport  ttyr8        GTEMP               TM Row Excl
REM      11  SYS              usupport  ttyr8        Trans-196622       TX Exclusive
REM      12  SYSTEM       usupport  ttyr6        INDEX_BLOCKS  TM Row Excl
REM      12  SYSTEM       usupport  ttyr6        Trans-131080       TX Exclusive
REM
REM ------------------------------------------------------------------------
REM DISCLAIMER:
REM    This script is provided for educational purposes only. It is NOT
REM    supported by Oracle World Wide Technical Support.
REM    The script has been tested and appears to work as intended.
REM    You should always run new scripts on a test instance initially.
REM ------------------------------------------------------------------------
REM Main text of script follows:

set echo off
set pagesize 60
Column SID         FORMAT 999 heading "Sess|ID "
COLUMN OBJECT_NAME FORMAT A17 heading "OBJ NAME or|TRANS_ID" Trunc
COLUMN OSUSER      FORMAT A10 heading "Op Sys|User ID"
COLUMN USERNAME    FORMAT A8
COLUMN TERMINAL    FORMAT A8  trunc
select B.SID, C.USERNAME, C.OSUSER, C.TERMINAL,
       DECODE(B.ID2, 0, A.OBJECT_NAME,
            'Trans-'||to_char(B.ID1)) OBJECT_NAME,  
			B.TYPE,
       DECODE(B.LMODE,0,'--Waiting--',
                      1,'Null',
                      2,'Row Share',
                      3,'Row Excl',
                   4,'Share',
                      5,'Sha Row Exc',
           6,'Exclusive',
                        'Other') "Lock Mode",
       DECODE(B.REQUEST,0,' ',
                      1,'Null',
                      2,'Row Share',
                      3,'Row Excl',
                      4,'Share',
                      5,'Sha Row Exc',
                      6,'Exclusive',
                     'Other') "Req Mode"
  from DBA_OBJECTS A, V$LOCK B, V$SESSION C
where A.OBJECT_ID(+) = B.ID1
  and B.SID = C.SID
  and C.USERNAME is not null
order by B.SID, B.ID2;