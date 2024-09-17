return {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ":TSUpdate",
    dependencies = {
        { 'windwp/nvim-ts-autotag', lazy = false, opts = { enable_rename = true } },
    },
    opts = {
        -- A list of parser names, or "all" (the five listed parsers should always be installed)
        ensure_installed = {
            "c",
            "lua",
            "vim",
            "vimdoc",
            "query",
            "javascript",
            "rust",
            "typescript",
            "gitignore",
            "go",
            "gleam",
            "graphql",
            "html",
            "json",
            "php",
            "python",
            "sql",
            "vue",
            "css",
            "scss",
        },
        sync_install = false,
        auto_install = true,
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
        autotag = {
            enable = true,
            enable_rename = true
        },
        autopairs = {
            enable = true,
        },
        indent = {
            enable = true,
        }
    },
    config = function(_, opts)
        require 'nvim-treesitter.configs'.setup(opts)
    end
};
