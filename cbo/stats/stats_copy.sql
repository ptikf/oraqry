exec dbms_stats.create_stat_table(
'CARP_TEST',
'STATTAB_SCHEMA4757',
'CARP_DATA');

exec dbms_stats.export_schema_stats (
'CARP',
'STATTAB_SCHEMA4757',
'CARP',
'CARP_test');

exec dbms_stats.create_stat_table(
'CARP',
'STATTAB_PTIKF',
'CARP_DATA');

exec dbms_stats.export_table_stats (
'CARP',
'TRANSACTION',
null,
'STATTAB_PTIKF',
null,
TRUE,
null);

exec dbms_stats.import_table_stats (
'CARP',
'TRANSACTION_PTIKF',
null,
'STATTAB_PTIKF',
null,
FALSE,
null);

exec dbms_stats.import_schema_stats (
'CARP',
'CARP_STATT_SCHEMA',
'CARP',
'CARP',
FALSE,
TRUE);
