-- FAQ: Detecting and Resolving Locking Conflicts and Ora-00060 errors (Doc ID 15476.1)
-- The following table describes what lock modes on DML enqueues are actually gotten for which table operations in a standard Oracle installation.
-- Operation                  Lock Mode LMODE Lock Description
-- ------------------------- --------- ----- ----------------
-- Select                     NULL      1     null
-- Select for update          SS        2     sub share
-- Insert                     SX        3     sub exclusive
-- Update                     SX        3     sub exclusive
-- Delete                     SX        3     sub exclusive
-- Lock For Update            SS        2     sub share
-- Lock Share                  S        4     share
-- Lock Exclusive              X        6     exclusive
-- Lock Row Share             SS        2     sub share
-- Lock Row Exclusive         SX        3     sub exclusive
-- Lock Share Row Exclusive   SSX       5     share/sub exclusive
-- Alter table                 X        6     exclusive
-- Drop table                  X        6     exclusive
-- Create Index                S        4     share
-- Drop Index                  X        6     exclusive
-- Truncate table              X        6     exclusive



-- Comments on a few of the columns:
-- --------------------------------
-- XIDUSN          Rollback Segment ID       }  Transaction ID is
-- XIDSLOT         Slot in RBS TX table      }   USN.SLOT.SQN or
-- XIDSQN          Wrap of the entry         }  TX-USNxSLOT-SQNxxxxx
--
-- UBAFIL          File for last undo entry  }  Tail end of UNDO for
-- UBABLK          Block for last undo entry }  this transaction
-- UBASQN          Sequence no of last entry }
-- UBAREC          Record no in the block    }

------------------------------------------------------------------------------------- 
-- ${ORACLE_HOME}/rdbms/admin/dbmslock.sql
-- http://www.morganslibrary.org/reference/pkgs/dbms_lock.html
-------------------------------------------------------------------------------------  
	     <-------- REQUEST --------->
held      NL  SS   SX   S    SSX  X
1 NL     YES SUCC SUCC SUCC SUCC SUCC
2 SS     YES SUCC SUCC SUCC SUCC fail
3 SX     YES SUCC SUCC fail fail fail
4 S      YES SUCC fail SUCC fail fail
5 SSX    YES SUCC fail fail fail fail
6 X      YES fail fail fail fail fail

----------------------------------------------------------------------------------------------
-- VIEW: "V$LOCK" Reference Note (Doc ID 29787.1)
----------------------------------------------------------------------------------------------
ID1 and ID2 depend on the lock TYPE. Most Common Lock Types:
---------------------------------------------------------------
TYPE  Name            	ID1                        ID2
~~~~  ~~~~            	~~~                        ~~~
UL    User Locks    
ST    Space Transaction Only ONE enqueue.	  
TM    Table Locks     	Object id of table.        Always 0.
TS    Temp Segment    	TS#            			   Relative DBA
TX    Transaction       Decimal RBS & slot         Decimal WRAP number
                        (0xRRRRSSSS  RRRR = RBS number, SSSS = slot )
      A TX lock is requested in eXclusive mode if we are waiting on a ROW. 
      A SHARE mode request implies we are waiting some other resource held by the TX 
	  (Eg: waiting for an ITL entry)

--
-- Lewis: http://jonathanlewis.wordpress.com/2010/06/21/locks/
--	  
Lock modes	  
Value   Name(s)                    Table method (TM lock)
    0   No lock                    n/a
 
    1   Null lock (NL)             Used during some parallel DML operations (e.g. update) by
                                   the pX slaves while the QC is holding an exclusive lock.
 
    2   Sub-share (SS)             Until 9.2.0.5/6 "select for update"
        Row-share (RS)             Since 9.2.0.1/2 used at opposite end of RI during DML
                                   Lock table in row share mode
                                   Lock table in share update mode
 
    3   Sub-exclusive(SX)          Update (also "select for update" from 9.2.0.5/6)
        Row-exclusive(RX)          Lock table in row exclusive mode
                                   Since 11.1 used at opposite end of RI during DML
 
    4   Share (S)                  Lock table in share mode
                                   Can appear during parallel DML with id2 = 1, in the PX slave sessions
                                   Common symptom of "foreign key locking" (missing index) problem
 
    5   share sub exclusive (SSX)  Lock table in share row exclusive mode
        share row exclusive (SRX)  Less common symptom of "foreign key locking" but likely to be more
                                   frequent if the FK constraint is defined with "on delete cascade."
 
    6   Exclusive (X)              Lock table in exclusive mode	  
	  
--
--
--	  
----------------------------------------------------------------------------------
Lock Conversion Summary
													  <-------- REQUEST -------->
	LMODE 		   Description        			Name  NULL  SS   SX   S   SSX   X
~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
0,1 No Lock        no permissions   KJUSERNL    NULL  YES  YES  YES  YES  YES  YES
  2 Sub-Share      concurrent read  KJUSERCR   SS,RS  YES  YES  YES  YES  YES  no
    Row-Share
  3 Sub-Exclusive  concurrent write KJUSERCW      SX  YES  YES  YES  no   no   no
    Row-Exclusive 
  4 Share          protected  read  KJUSERPR       S  YES  YES  no   YES  no   no
  5 Sub-Share-Excl protected  write KJUSERPW SRX,SSX  YES  YES  no   no   no   no
    Share-Row-Excl
  6 Exclusive	   exclusive access KJUSEREX       X  YES  no   no   no   no   no
----------------------------------------------------------------------------------
	
												DML Table Lock Mode
									 Yes      Yes     No      No     ROW-LOCKING
   Operation          Table Access    No      Yes     No      Yes    SERIALIZABLE
--------------      --------------- ------- ------- ------- -------
Select              Read             NULL     S       NULL    S
Select For Update   Row-Read         SS       S       SS      S
Insert              Row-Write        SX       SX      SSX     SSX
Update              Read-Row-Write   SX       SSX     SSX     SSX
Delete              Read-Row-Write   SX       SSX     SSX     SSX
Lock For Update     Row-Read         SS       S       SS      S
 
Lock Share                           S        S       S       S
Lock Exclusive                       X        X       X       X
     
Lock Row Share                       SS       SS      SS      SS
Lock Row Exclusive                   SX       SX      SX      SX
Lock Share Row      Exclusive        SSX      SSX     SSX     SSX
     
Alter               Write            X        X       X       X
Drop                Write            X        X       X       X
Create Index                         S        S       S       S
Drop Index          Write            X        X       X       X