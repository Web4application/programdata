(executable
 (name mo_ld)
 (modules mo_ld)
 (libraries wasm_exts linking)
 (instrumentation (backend bisect_ppx --bisect-silent yes))
)
