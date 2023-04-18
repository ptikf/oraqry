select 
table_owner own,
table_name tname,
partition_name pname,
subpartition_name subpname,
high_value,
subpartition_position subpos,
tablespace_name tsname,
max_trans,
num_rows,
blocks,
last_analyzed,
global_stats gstats,
user_stats ustats
 from 
all_tab_subpartitions 
where table_name = 'T_PART' 
order by partition_name,subpartition_position ;