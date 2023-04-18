--
-- Histo character
--
select  endpoint_number,
        endpoint_number - nvl(prev_endpoint,0)  frequency,
        hex_val,
        chr(to_number(substr(hex_val, 2,2),'XX')) ||
        chr(to_number(substr(hex_val, 4,2),'XX')) ||
        chr(to_number(substr(hex_val, 6,2),'XX')) ||
        chr(to_number(substr(hex_val, 8,2),'XX')) ||
        chr(to_number(substr(hex_val,10,2),'XX')) ||
        chr(to_number(substr(hex_val,12,2),'XX')) col ,
        endpoint_actual_value
from    (  select endpoint_number, lag(endpoint_number,1) over( order by endpoint_number ) prev_endpoint,
                to_char(endpoint_value,'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX')hex_val,
                endpoint_actual_value
        from dba_tab_histograms
        where owner = 'CARP'
        and     table_name = 'TRANSACTION'
        and     column_name = 'DIC_STATUT_TRANSACTION'
        ) order by endpoint_number ;

 --
 -- Histo generique
 --
select endpoint_value, endpoint_number-nvl(prev_endpoint,0)  frequency
from ( select endpoint_number,
        lag(endpoint_number,1) over( order by endpoint_number ) prev_endpoint,
        endpoint_value
    from all_tab_histograms
    where  owner = 'CARP' 
	and table_name  = 'TRANSACTION' and column_name = 'DIC_STATUT_TRANSACTION' )
order by endpoint_number ;
