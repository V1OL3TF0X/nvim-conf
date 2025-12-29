return {
  'V1OL3TF0X/tailwindcss-colors.nvim',
  -- load only on require("tailwindcss-colors")
  main = 'tailwindcss-colors',
  -- run the setup function after plugin is loaded
  config = function()
    require('tailwindcss-colors').setup()
  end,
}
