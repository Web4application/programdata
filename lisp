;; === Dullo Project Dune File (Refactored) ===

;; Common instrumentation for coverage
(env
 (dev
  (flags (:standard -w -32))
  (instrumentation (backend bisect_ppx --bisect-silent yes))))

;; Common library sets
;; You can expand these lists if new executables share the same deps
(library
 (name common_libs)
 (libraries))

;; === Executables ===
(executable
 (name moc)
 (modules moc)
 (libraries profiler pipeline source_id common_libs))

(executable
 (name mo_ld)
 (modules mo_ld)
 (libraries wasm_exts linking common_libs))

(executable
 (name mo_doc)
 (modules mo_doc)
 (libraries docs common_libs))

(executable
 (name didc)
 (modules didc)
 (libraries lib idllib source_id common_libs))

(executable
 (name deser)
 (modules deser)
 (libraries stdio num source_id common_libs))

;; === Tests ===
(test
 (name candid_tests)
 (modules candid_tests)
 (libraries lib idllib mo_idl mo_values lang_utils common_libs))

;; === Aliases ===
(alias
 (name dullo)
 (deps
  (alias runtest)
  (alias all)))
