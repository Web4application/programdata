(executable
 (name moc)
 (modules moc)
 (libraries profiler pipeline source_id)
 (instrumentation (backend bisect_ppx --bisect-silent yes))
)
