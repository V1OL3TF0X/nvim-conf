return {
    "themaxmarchuk/tailwindcss-colors.nvim",
    -- load only on require("tailwindcss-colors")
    main = "tailwindcss-colors",
    dependencies = { 'VonHeikemen/lsp-zero.nvim' },
    -- run the setup function after plugin is loaded
    config = function()
        require 'tailwindcss-colors'.setup()
    end
}
