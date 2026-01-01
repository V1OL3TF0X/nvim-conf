local slow_format_filetypes = {}
vim.api.nvim_create_user_command('FormatDisable', function(args)
  if args.bang then
    -- FormatDisable! will disable formatting just for this buffer
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, {
  desc = 'Disable autoformat-on-save',
  bang = true,
})
vim.api.nvim_create_user_command('FormatEnable', function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, {
  desc = 'Re-enable autoformat-on-save',
})
local js_like_formatters = { 'prettier', stop_after_first = true };
local function use_local_and_global_config(roots, name)
  require('conform.formatters.' .. name).args = function(self, ctx)
    local args = { '--stdin-filepath', '$FILENAME' }

    local localConfig = vim.fs.find(roots, {
      upward = true,
      path = ctx.dirname,
      type = 'file'
    })[1]
    local globalConfig = vim.fs.find(roots, {
      path = vim.fn.stdpath('config'),
      type = 'file'
    })[1]
    local disableGlobalConfig = os.getenv('DISABLE_GLOBAL_' .. string.upper(name) .. '_CONFIG')

    -- Project config takes precedence over global config
    if localConfig then
      vim.list_extend(args, { '--config', localConfig })
    elseif globalConfig and not disableGlobalConfig then
      vim.list_extend(args, { '--config', globalConfig })
    end

    return args
  end
end
return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      -- Customize or remove this keymap to your liking
      '<leader>f',
      function()
        require('conform').format { async = true, lsp_fallback = true }
      end,
      mode = 'n',
      desc = 'Format buffer',
    },
  },
  opts = {
    quiet = false,
    formatters_by_ft = {
      javascript = js_like_formatters,
      typescript = js_like_formatters,
      typescriptreact = js_like_formatters,
      javascriptreact = js_like_formatters,
      json = js_like_formatters,
      svelte = js_like_formatters,
      css = js_like_formatters,
      scss = js_like_formatters,
      astro = js_like_formatters,
      html = js_like_formatters,
      php = js_like_formatters,
      djangohtml = js_like_formatters,
      java = { 'jdtls' },
      lua = { 'stylua' },
    },
    format_on_save = function(bufnr)
      -- Disable autoformat for files in a certain path
      local bufname = vim.api.nvim_buf_get_name(bufnr)
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      if bufname:match '/node_modules/' then
        return
      end
      if slow_format_filetypes[vim.bo[bufnr].filetype] then
        return
      end
      local function on_format(err)
        if err and err:match 'timeout$' then
          slow_format_filetypes[vim.bo[bufnr].filetype] = true
        end
      end

      return { timeout_ms = 200, lsp_fallback = true }, on_format
    end,
    format_after_save = function(bufnr)
      if
          not slow_format_filetypes[vim.bo[bufnr].filetype]
          or vim.g.disable_autoformat
          or vim.b[bufnr].disable_autoformat
      then
        return
      end
      return { lsp_fallback = true }
    end,
  },
  config = function(_, opts)
    require('conform').setup(opts)
    -- Customize prettier args
    use_local_and_global_config({ '.prettierrc', '.prettierrc.json', 'prettier.config.js', '.prettierrc.toml' },
      'prettier');
    use_local_and_global_config({ 'biome.json', 'biome.jsonc' }, 'biome')
  end,
}
