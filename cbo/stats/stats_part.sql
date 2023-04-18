select ptabs.owner,ptabs.table_name tname,ptabs.column_name cname,
tabc.data_type,
ptabs.partition_name pname,
ptabs.num_distinct dstinct,
decode(data_type
  ,'NUMBER'  ,to_char(utl_raw.cast_to_number(ptabs.low_value))
  ,'VARCHAR2',to_char(utl_raw.cast_to_varchar2(ptabs.low_value))) lvalue,
decode(data_type
  ,'NUMBER'  ,to_char(utl_raw.cast_to_number(ptabs.high_value))
  ,'VARCHAR2',to_char(utl_raw.cast_to_varchar2(ptabs.high_value))) hvalue,
ptabs.density,
ptabs.num_nulls nulls ,
ptabs.num_buckets bckts,
ptabs.last_analyzed,
ptabs.global_stats glob,
ptabs.histogram histo
from all_part_col_statistics ptabs, all_tab_cols tabc
where ptabs.owner=tabc.owner and ptabs.table_name=tabc.table_name and ptabs.column_name=tabc.column_name 
and ptabs.table_name = 'T_PART' 
and ptabs.owner = user 
order by 
ptabs.column_name,
ptabs.partition_name ;

select 
table_owner own,
table_name tname ,
partition_name PNAME, 
SUBPARTITION_COUNT subp, 
HIGH_VALUE high_val, 
PARTITION_POSITION p_pos, 
tablespace_name TBSPACE, 
max_trans MXTRNS, 
NUM_ROWS nrws, 
BLOCKS blks, 
AVG_SPACE avgspc, 
AVG_ROW_LEN avgrln, 
LAST_ANALYZED, 
GLOBAL_STATS gstats, 
USER_STATS ustats 
from all_tab_partitions where 
table_name = 'T_PART' order by partition_position;

select 
owner own,
segment_name sname,
partition_name pname,
segment_type,
tablespace_name tsname,
bytes,
blocks from dba_segments 
where owner=user 
and segment_name = 'T_PART' ;