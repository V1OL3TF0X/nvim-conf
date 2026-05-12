local slow_format_filetypes = {}
local cached_formatter_per_packages_path = {}
local cached_formatter_per_bufnr = {}
local function cache_formatter(formatter, bufnr, path)
  local fmt = { formatter }
  cached_formatter_per_bufnr[bufnr] = fmt
  cached_formatter_per_packages_path[path] = fmt
  return fmt
end
vim.api.nvim_create_user_command('FormatDisable', function(args)
  if args.bang then
    -- FormatDisable! will disable formatting just for this buffer
    vim.g.disable_autoformat = true
  else
    vim.b.disable_autoformat = true
  end
end, {
  desc = 'Disable autoformat-on-save',
  bang = true,
})
vim.api.nvim_create_user_command('FormatEnable', function(args)
  if args.bang then
    vim.g.disable_autoformat = false
  else
    vim.b.disable_autoformat = false
  end
end, {
  desc = 'Re-enable autoformat-on-save',
  bang = true,
})
vim.api.nvim_create_user_command('NukeFormatterCache', function()
  cached_formatter_per_bufnr = {}
  cached_formatter_per_packages_path = {}
end, { desc = 'Reset cached formatters by bufnr / path' })
local js_like_formatters = function(bufnr)
  if cached_formatter_per_bufnr[bufnr] ~= nil then
    return cached_formatter_per_bufnr[bufnr]
  end
  local package_json = vim.fs.find('package.json', { type = 'file' })
  if #package_json == 0 then
    package_json = vim.fs.find('package.json', { upward = true, type = 'file' })
  end
  if #package_json == 0 then
    cached_formatter_per_bufnr[bufnr] = 'prettier'
    return { 'prettier' }
  end
  local path = package_json[1]
  if cached_formatter_per_packages_path[path] ~= nil then
    return cached_formatter_per_packages_path[path]
  end
  local res = vim.system({
    'jq',
    '.dependencies + .devDependencies | keys | map(select(. == "prettier" or . == "biome" or . == "oxfmt" or . == "vite-plus"))',
    path,
  }, { text = true })
  if res.code ~= 0 then
    return cache_formatter('prettier', bufnr, path)
  end
  local ok, packages_tbl = pcall(vim.json.decode, res.stdout)
  if not ok then
    return cache_formatter('prettier', bufnr, path)
  end

  if vim.tbl_contains(packages_tbl, 'vite-plus') then
    return cache_formatter('vite-plus', bufnr, path)
  end
  if vim.tbl_contains(packages_tbl, 'oxfmt') then
    return cache_formatter('oxfmt', bufnr, path)
  end
  if vim.tbl_contains(packages_tbl, 'biome') then
    return cache_formatter('biome', bufnr, path)
  end
  return cache_formatter('prettier', bufnr, path)
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
      yaml = { 'yamlfix' },
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
}
