((html_tag) @injection.content
  (#set! injection.language "html")
  (#set! injection.combined))

; inject tex (Treesitter)
((latex_block) @injection.content
  (#set! injection.language "tex")
  (#set! injection.include-children))
