local slow_format_filetypes = {}
vim.api.nvim_create_user_command("FormatDisable", function(args)
  if args.bang then
    -- FormatDisable! will disable formatting just for this buffer
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, {
  desc = "Disable autoformat-on-save",
  bang = true,
})
vim.api.nvim_create_user_command("FormatEnable", function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, {
  desc = "Re-enable autoformat-on-save",
})
return {
  'stevearc/conform.nvim',
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      -- Customize or remove this keymap to your liking
      "<leader>f",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      mode = "n",
      desc = "Format buffer",
    },
  },
  opts = {
    quiet = false,
    formatters_by_ft = {
      javascript = { 'prettier' },
      typescript = { 'prettier' },
      typescriptreact = { 'prettier' },
      javascriptreact = { 'prettier' },
      json = { 'prettier' },
      css = { 'prettier' },
      scss = { 'prettier' },
      astro = { 'prettier' },
      html = { 'prettier' },
      php = { 'prettier' },
      djangohtml = { 'prettier' },
      java = { 'jdtls' },
    },
    format_on_save = function(bufnr)
      -- Disable autoformat for files in a certain path
      local bufname = vim.api.nvim_buf_get_name(bufnr)
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      if bufname:match('/node_modules/') then
        return
      end
      if slow_format_filetypes[vim.bo[bufnr].filetype] then
        return
      end
      local function on_format(err)
        if err and err:match("timeout$") then
          slow_format_filetypes[vim.bo[bufnr].filetype] = true
        end
      end

      return { timeout_ms = 200, lsp_fallback = true }, on_format
    end,
    format_after_save = function(bufnr)
      if not slow_format_filetypes[vim.bo[bufnr].filetype] or vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      return { lsp_fallback = true }
    end,
  },
  config = function(_, opts)
    require 'conform'.setup(opts)
    -- Customize prettier args
    require('conform.formatters.prettier').args = function(self, ctx)
      local prettier_roots = { '.prettierrc', '.prettierrc.json', 'prettier.config.js', '.prettierrc.toml' }
      local args = { '--stdin-filepath', '$FILENAME' }

      local localPrettierConfig = vim.fs.find(prettier_roots, {
        upward = true,
        path = ctx.dirname,
        type = 'file'
      })[1]
      local globalPrettierConfig = vim.fs.find(prettier_roots, {
        path = vim.fn.stdpath('config'),
        type = 'file'
      })[1]
      local disableGlobalPrettierConfig = os.getenv('DISABLE_GLOBAL_PRETTIER_CONFIG')

      -- Project config takes precedence over global config
      if localPrettierConfig then
        vim.list_extend(args, { '--config', localPrettierConfig })
      elseif globalPrettierConfig and not disableGlobalPrettierConfig then
        vim.list_extend(args, { '--config', globalPrettierConfig })
      end

      local hasTailwindPrettierPlugin = vim.fs.find('node_modules/prettier-plugin-tailwindcss', {
        upward = true,
        path = ctx.dirname,
        type = 'directory'
      })[1]

      if hasTailwindPrettierPlugin then
        vim.list_extend(args, { '--plugin', 'prettier-plugin-tailwindcss' })
      end

      return args
    end
  end,
};
