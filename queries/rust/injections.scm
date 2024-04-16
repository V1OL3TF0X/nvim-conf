;;; raw string sqlx::query!
((macro_invocation
  (scoped_identifier
    path: (identifier) @_path
    name: (identifier) @_name)
  (token_tree
    (raw_string_literal) @injection.content)
 (#eq? @_name "query")
 (#eq? @_path "sqlx"))
 (#set! injection.include-children)
 (#set! injection.language "sql")
 (#offset! @injection.content 0 3 0 -2))

;;; string literal sqlx::query!
((macro_invocation
  (scoped_identifier
    path: (identifier) @_path
    name: (identifier) @_name)
  (token_tree
    . (string_literal) @injection.content)
 (#eq? @_name "query")
 (#eq? @_path "sqlx"))
 (#set! injection.include-children)
 (#set! injection.language "sql")
 (#offset! @injection.content 0 1 0 -1))

;;; raw string sqlx::query_as!
((macro_invocation
  (scoped_identifier
    path: (identifier) @_path
    name: (identifier) @_name)
  (token_tree
    (identifier)
    (raw_string_literal) @injection.content)
 (#eq? @_name "query_as")
 (#eq? @_path "sqlx"))
 (#set! injection.include-children)
 (#set! injection.language "sql")
 (#offset! @injection.content 0 3 0 -2))

;;; string literal sqlx::query!
((macro_invocation
  (scoped_identifier
    path: (identifier) @_path
    name: (identifier) @_name)
  (token_tree 
    (identifier)
    (string_literal) @injection.content)
 (#eq? @_name "query_as")
 (#eq? @_path "sqlx"))
 (#set! injection.include-children)
 (#set! injection.language "sql")
 (#offset! @injection.content 0 1 0 -1))
