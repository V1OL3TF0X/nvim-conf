local thisFilePath = (... or 'setup.plugins.lua'):match("(.-)[^%.]+$")

return {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    lazy = false,
    dependencies = {
        --- Uncomment the two plugins below if you want to manage the language servers from neovim
        { 'williamboman/mason.nvim' },
        { 'williamboman/mason-lspconfig.nvim' },

        -- LSP Support
        { 'neovim/nvim-lspconfig' },
        -- Autocompletion
        { 'hrsh7th/nvim-cmp' },
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'L3MON4D3/LuaSnip' },
    },
    config = function()
        local parser_config = require 'nvim-treesitter.parsers'.get_parser_configs()
        parser_config.gotmpl = {
            install_info = {
                url = "https://github.com/ngalaiko/tree-sitter-go-template",
                files = { "src/parser.c" }
            },
            filetype = "gotmpl",
            used_by = { "gohtmltmpl", "gotexttmpl", "gotmpl" }
        }
        local lsp = require("lsp-zero")

        lsp.preset("recommended")

        local cmp = require('cmp')
        local cmp_select = { behavior = cmp.SelectBehavior.Select }
        local cmp_mappings = cmp.mapping.preset.insert {
            ['<S-Tab>'] = cmp.mapping.select_prev_item(cmp_select),
            ['<Tab>'] = cmp.mapping.select_next_item(cmp_select),
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
            ["<C-Space>"] = cmp.mapping.complete(),
        }

        cmp.setup {
            mapping = cmp_mappings,
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            }
        }

        lsp.set_preferences {
            suggest_lsp_servers = true,
            sign_icons = {
                error = 'E',
                warn = 'W',
                hint = 'H',
                info = 'I'
            }
        }

        lsp.on_attach(function(client, bufnr)
            local opts = { buffer = bufnr, remap = false }

            vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
            vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
            vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
            vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
            vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
            vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
            vim.keymap.set("n", "<leader>.", function() vim.lsp.buf.code_action({ apply = true }) end, opts)
            vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
            vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
            vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
        end)

        lsp.setup()
        require('mason').setup {}
        local lspconf = require 'lspconfig'
        local standard_handlers = {
            lsp.default_setup,
            lua_ls = function()
                local lua_opts = lsp.nvim_lua_ls()
                lspconf.lua_ls.setup(lua_opts)
            end,
            angularls = function()
                lspconf.angularls.setup {}
            end
        }
        local handlers = vim.iter({ 'htmx', 'tailwindcss', 'intelephense', 'rust_analyzer' }):fold(standard_handlers,
            function(table, item)
                table[item] = function()
                    lspconf[item].setup(require(thisFilePath .. 'lsp_configs.' .. item))
                end
                return table
            end)
        require('mason-lspconfig').setup {
            -- Replace the language servers listed here
            -- with the ones you want to install
            ensure_installed = { 'tsserver', 'rust_analyzer', 'lua_ls', 'volar', 'html', 'htmx', 'gopls', 'graphql', 'lua_ls', 'powershell_es' },
            handlers = handlers
        }
        vim.diagnostic.config {
            virtual_text = true
        }
    end,
};
