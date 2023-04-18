select endpoint_value, bucket_number-nvl(prev_endpoint,0)  frequency
from ( select bucket_number,
        lag(bucket_number,1) over( order by bucket_number ) prev_endpoint,
        endpoint_value
    from all_part_histograms
    where  owner = user
	and table_name  = 'T_PART' and column_name = 'FK' 
    and partition_name = 'P000')
order by bucket_number ;

--
-- histogramme par partition
--
select 
endpoint_value,
max( decode(partition_name,'P000', bucket_number, null ) ) P000,
max( decode(partition_name,'P010', bucket_number, null ) ) P010,
max( decode(partition_name,'P020', bucket_number, null ) ) P015,
max( decode(partition_name,'P020', bucket_number, null ) ) P020,
max( decode(partition_name,'P100', bucket_number, null ) ) P100,
max( decode(partition_name,'P999', bucket_number, null ) ) P999
from 
( select endpoint_value,partition_name,bucket_number
from all_part_histograms where table_name = 'T_PART' and column_name = 'VAL'  
) group by endpoint_value  order by endpoint_value ;