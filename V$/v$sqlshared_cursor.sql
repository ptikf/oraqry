select 
sql_id ,
--address ,
--child_address  ,
child_number  cn,
-- USOOSLSEBPISTABDLTRIIRLIOSMUTNFAITDLDBPCSRPTMBMROPMFL
unbound_cursor UB ,
sql_type_mismatch Sm ,
optimizer_mismatch om ,
outline_mismatch lm,
stats_row_mismatch sr,
literal_mismatch LT,
force_hard_parse hp,
explain_plan_cursor Xc,
buffered_dml_mismatch bm,
pdml_env_mismatch pe,
inst_drtld_mismatch Im,
slave_qc_mismatch Sq,
typecheck_mismatch Ty,
auth_check_mismatch am,
bind_mismatch Bs,
describe_mismatch Dh ,
language_mismatch Ls,
translation_mismatch Th ,
bind_equiv_failure bf,
insuff_privs ip,
insuff_privs_rem ir,
remote_trans_mismatch Rt,
logminer_session_mismatch Lg,
incomp_ltrl_mismatch it,
overlap_time_mismatch ov,
edition_mismatch em ,
mv_query_gen_mismatch mv,
user_bind_peek_mismatch up,
typchk_dep_mismatch tp,
no_trigger_mismatch no,
flashback_cursor fh,
anydata_transformation ay,
incomplete_cursor cr,
top_level_rpi_cursor tl,
different_long_length dl,
logical_standby_apply la,
diff_call_durn dc,
bind_uacs_diff bu,
plsql_cmp_switchs_diff pl,
cursor_parts_mismatch cm,
stb_object_mismatch so,
crossedition_trigger_mismatch co,
pq_slave_mismatch ps,
top_level_ddl_mismatch dd,
multi_px_mismatch px,
bind_peeked_pq_mismatch pq,
mv_rewrite_mismatch mw ,
roll_invalid_mismatch rl,
optimizer_mode_mismatch oi,
px_mismatch pt,
mv_staleobj_mismatch ms,
flashback_table_mismatch fi,
litrep_comp_mismatch lh,
plsql_debug pd,
load_optimizer_stats os,
acl_mismatch ac,
flashback_archive_mismatch fa,
lock_user_schema_failed lk,
remote_mapping_mismatch rm,
load_runtime_heap_failed lf,
hash_match_failed hs,
purged_cursor pu,
bind_length_upgradeable bl
from v$sql_shared_cursor ;
