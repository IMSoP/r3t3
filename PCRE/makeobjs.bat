bcc32 -DHAVE_CONFIG_H -DSUPPORT_UTF8 -DSUPPORT_UCP dftables.c
dftables.exe pcre_chartables.c
bcc32 -c -u- -v- -DHAVE_CONFIG_H -DSUPPORT_UTF8 -DSUPPORT_UCP -DSTATIC -DNO_RECURSE -w-8012 pcre_chartables.c pcre_compile.c pcre_config.c pcre_dfa_exec.c pcre_exec.c pcre_fullinfo.c pcre_get.c pcre_globals.c pcre_info.c pcre_maketables.c pcre_ord2utf8.c pcre_refcount.c pcre_study.c pcre_tables.c pcre_try_flipped.c pcre_ucd.c pcre_valid_utf8.c pcre_version.c pcre_xclass.c pcreposix.c pcre_newline.c
