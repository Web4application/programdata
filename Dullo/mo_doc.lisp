(executable
 (name mo_doc)
 (modules mo_doc)
 (libraries docs)
 (instrumentation (backend bisect_ppx --bisect-silent yes))
)
