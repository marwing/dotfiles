;; extends

(method_invocation
  name: (identifier) @_matches (#eq? @_matches "matches")
  arguments: (argument_list
               (string_literal) @regex))

(method_invocation
  object: (identifier) @_pattern (#eq? @_pattern "Pattern")
  name: (identifier) @_compile (#eq? @_compile "compile")
  arguments: (argument_list
               (string_literal) @regex))
