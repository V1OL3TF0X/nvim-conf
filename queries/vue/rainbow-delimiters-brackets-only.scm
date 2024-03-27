;;; A Vue file is made up of top-level tags which contain code written in other
;;; languages

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

(template_element
  (start_tag
    "<" @delimiter
    (tag_name)
    ">" @delimiter)
  (end_tag
    "</" @delimiter
    (tag_name)
    ">" @delimiter @sentinel)) @container

(script_element
  (start_tag
    "<" @delimiter
    (tag_name)
    ">" @delimiter)
  (end_tag
    "</" @delimiter
    (tag_name)
    ">" @delimiter @sentinel)) @container

(style_element
  (start_tag
    "<" @delimiter
    (tag_name)
    ">" @delimiter)
  (end_tag
    "</" @delimiter
    (tag_name)
    ">" @delimiter @sentinel)) @container

(interpolation
  "{{" @delimiter
  "}}" @delimiter @sentinel) @container
