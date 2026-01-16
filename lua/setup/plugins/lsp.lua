local function nvim_lua_config(opts)
  local runtime_path = vim.split(package.path, ';')
  table.insert(runtime_path, 'lua/?.lua')
  table.insert(runtime_path, 'lua/?/init.lua')

  local config = {
    settings = {
      Lua = {
        -- Disable telemetry
        telemetry = { enable = false },
        runtime = {
          -- Tell the language server which version of Lua you're using
          -- (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
          path = runtime_path,
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { 'vim' },
        },
        workspace = {
          checkThirdParty = false,
          library = {
            -- Make the server aware of Neovim runtime files
            vim.env.VIMRUNTIME,
            '${3rd}/luv/library',
          },
        },
      },
    },
  }

  return vim.tbl_deep_extend('force', config, opts or {})
end
return {
  'mason-org/mason-lspconfig.nvim',
  lazy = false,
  dependencies = {
    {
      'mason-org/mason.nvim',
    },
    --- Uncomment the two plugins below if you want to manage the language servers from neovim
    { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
    -- LSP Support
    { 'b0o/schemastore.nvim' },
    { 'neovim/nvim-lspconfig' },
  },
  config = function()
    require('nvim-treesitter.parsers').gotmpl = {
      install_info = {
        url = 'https://github.com/ngalaiko/tree-sitter-go-template',
        files = { 'src/parser.c' },
      },
      filetype = 'gotmpl',
      used_by = { 'gohtmltmpl', 'gotexttmpl', 'gotmpl' },
    }

    vim.lsp.config('*', {
      capabilities = { textDocument = { hover = true } },
    })

    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(evt)
        local opts = { buffer = evt.buf, remap = false }

        -- stylua: ignore start
        vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set('n', 'gr', function() vim.lsp.buf.references() end, opts)
        vim.keymap.set('n', 'K', function() vim.lsp.buf.hover { border = 'rounded' } end, opts)
        vim.keymap.set('n', '<leader>vws', function() vim.lsp.buf.workspace_symbol() end, opts)
        vim.keymap.set('n', '<leader>vd', function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set('n', '[w', function() vim.diagnostic.jump { count = 1, float = true, severity = { max = 'WARN' } } end, opts)
        vim.keymap.set('n', ']w', function() vim.diagnostic.jump { count = -1, float = true, severity = { max = 'WARN' } } end, opts)
        vim.keymap.set('n', '[d', function() vim.diagnostic.jump { count = 1, float = true, severity = 'ERROR' } end, opts)
        vim.keymap.set('n', ']d', function() vim.diagnostic.jump { count = -1, float = true, severity = 'ERROR' } end, opts)
        vim.keymap.set('n', '<leader>.', function() vim.lsp.buf.code_action { apply = true } end, opts)
        vim.keymap.set('n', '<leader>vrr', function() vim.lsp.buf.references() end, opts)
        vim.keymap.set('n', '<leader>vrn', function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set('i', '<C-h>', function() vim.lsp.buf.signature_help() end, opts)
        vim.keymap.set('n', '<leader>ih', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, opts)
        -- stylua: ignore end
        local client = vim.lsp.get_client_by_id(evt.data.client_id)
        if not client then
          return
        end

        if client.name == 'eslint' then
          -- Define a command to organize imports
          vim.api.nvim_create_autocmd('BufWritePre', {
            buffer = evt.buf,
            command = 'LspEslintFixAll',
          })
        end
      end,
    })

    require('mason').setup {}
    require('mason-tool-installer').setup {
      ensure_installed = {
        'java-debug-adapter',
        'java-test',
      },
    }
    vim.api.nvim_command 'MasonToolsInstall'

    local lua_opts = nvim_lua_config()
    vim.lsp.config('lua_ls', lua_opts)
    vim.lsp.config('jsonls', {
      settings = {
        json = {
          schemas = require('schemastore').json.schemas(),
          validate = { enable = true },
        },
      },
    })
    require('mason-lspconfig').setup {
      -- Replace the language servers listed here
      -- with the ones you want to install
      -- stylua: ignore
      ensure_installed = { 'ts_ls', 'rust_analyzer', 'lua_ls', 'vue_ls', 'html', 'htmx', 'gopls', 'graphql', 'powershell_es', 'tailwindcss', 'jqls', 'eslint', 'jsonls', 'jdtls', },
      automatic_enable = { exclude = { 'jdtls' } },
    }

    vim.diagnostic.config {
      virtual_text = true,
    }
    vim.api.nvim_create_autocmd('User', {
      pattern = 'TSUpdate',
      callback = function()
        require('nvim-treesitter.parsers').arktype = {
          install_info = {
            url = 'https://github.com/jeffrom/tree-sitter-arktype',
            queries = 'queries', -- also install queries from given directory
          },
        }
      end,
    })
  end,
}
