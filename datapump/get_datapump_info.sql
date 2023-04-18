set serveroutput on
declare
 info  ku$_dumpfile_info;
 ft	number ;
begin
     dbms_datapump.get_dumpfile_info(
	 'expdp_ora_rmx02b11_qabo_58.02.2013_02_26.14_28_01.dmpdp',
	 'DPDIR',
	 info,ft);
   for rec in (select * from table(info)order by item_code) loop 
	   dbms_output.put_line(rec.item_code||' '||rec.value);
   end loop;
  end;
/
 
KU$_DFHDR_FILE_VERSION         CONSTANT NUMBER := 1;
KU$_DFHDR_MASTER_PRESENT       CONSTANT NUMBER := 2;
KU$_DFHDR_GUID                 CONSTANT NUMBER := 3;
KU$_DFHDR_FILE_NUMBER          CONSTANT NUMBER := 4;
KU$_DFHDR_CHARSET_ID           CONSTANT NUMBER := 5;
KU$_DFHDR_CREATION_DATE        CONSTANT NUMBER := 6;
KU$_DFHDR_FLAGS                CONSTANT NUMBER := 7;
KU$_DFHDR_JOB_NAME             CONSTANT NUMBER := 8;
KU$_DFHDR_PLATFORM             CONSTANT NUMBER := 9;
KU$_DFHDR_INSTANCE             CONSTANT NUMBER := 10;
KU$_DFHDR_LANGUAGE             CONSTANT NUMBER := 11;
KU$_DFHDR_BLOCKSIZE            CONSTANT NUMBER := 12;
KU$_DFHDR_DIRPATH              CONSTANT NUMBER := 13;
KU$_DFHDR_METADATA_COMPRESSED  CONSTANT NUMBER := 14;
KU$_DFHDR_DB_VERSION           CONSTANT NUMBER := 15;
KU$_DFHDR_MAX_ITEM_CODE        CONSTANT NUMBER := 20;
KU$_DFHDR_MASTER_PIECE_COUNT   CONSTANT NUMBER := 16;
KU$_DFHDR_MASTER_PIECE_NUMBER  CONSTANT NUMBER := 17;
KU$_DFHDR_DATA_COMPRESSED      CONSTANT NUMBER := 18;
KU$_DFHDR_METADATA_ENCRYPTED   CONSTANT NUMBER := 19;
KU$_DFHDR_DATA_ENCRYPTED       CONSTANT NUMBER := 20;