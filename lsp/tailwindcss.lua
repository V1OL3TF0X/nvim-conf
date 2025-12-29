return {
  on_attach = function(client, bufnr)
    require('tailwindcss-colors').buf_attach(bufnr)
  end,
}
