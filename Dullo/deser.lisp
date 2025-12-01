(executable
 (name deser)
 (modules deser)
 (libraries stdio num source_id)
 (instrumentation (backend bisect_ppx --bisect-silent yes))
)
