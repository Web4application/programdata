(executable
 (name didc)
 (modules didc)
 (libraries lib idllib source_id)
 (instrumentation (backend bisect_ppx --bisect-silent yes))
)
