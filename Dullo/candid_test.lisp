(executable
 (name candid_tests)
 (modules candid_tests)
 (libraries lib idllib mo_idl mo_values lang_utils)
 (instrumentation (backend bisect_ppx --bisect-silent yes))
)
