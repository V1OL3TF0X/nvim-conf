(element
  (start_tag
    "<" @delimiter
    (tag_name)
    ">" @delimiter)
  (end_tag
    "</" @delimiter
    (tag_name)
    ">" @delimiter @sentinel)) @container

(element
  (self_closing_tag
    "<" @delimiter
    (tag_name)
    "/>" @delimiter @sentinel)) @container

(attribute_interpolation
  "{" @delimiter
  "}" @delimiter @sentinel) @container
