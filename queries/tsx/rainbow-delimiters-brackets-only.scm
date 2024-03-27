; inherits: typescript

(jsx_element
  open_tag: (jsx_opening_element
              "<" @delimiter
              name: (identifier)
              ">" @delimiter)
  close_tag: (jsx_closing_element
               "</" @delimiter
               name: (identifier)
               ">" @delimiter @sentinel)) @container

(jsx_element
  open_tag: (jsx_opening_element
              "<" @delimiter
              name: (member_expression)
              ">" @delimiter)
  close_tag: (jsx_closing_element
              "</" @delimiter
               name: (member_expression)
              ">" @delimiter @sentinel)) @container

(jsx_self_closing_element
  "<" @delimiter
  name: (identifier)
  "/>" @delimiter @sentinel) @container


(jsx_self_closing_element
  "<" @delimiter
  name: (member_expression)
  "/>" @delimiter @sentinel) @container

(jsx_expression
  "{" @delimiter
  "}" @delimiter @sentinel) @container
