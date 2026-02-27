return {
  'mfussenegger/nvim-dap',
  dependencies = { 'mxsdev/nvim-dap-vscode-js', 'nvim-neotest/nvim-nio' },
  config = function()
    local dap = require 'dap'
    local widgets = require 'dap.ui.widgets'
    -- stylua: ignore start
   vim.keymap.set('n', '<F5>', function() dap.continue() end)
    vim.keymap.set('n', '<F10>', function() dap.step_over() end)
    vim.keymap.set('n', '<F11>', function() dap.step_into() end)
    vim.keymap.set('n', '<F12>', function() dap.step_out() end)
    vim.keymap.set('n', '<Leader>b', function() dap.toggle_breakpoint() end)
    vim.keymap.set('n', '<Leader>B', function() dap.set_breakpoint() end)
    vim.keymap.set('n', '<Leader>lp', function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
    vim.keymap.set('n', '<Leader>Dr', function() dap.repl.open() end)
    vim.keymap.set('n', '<Leader>Dl', function() dap.run_last() end)
    vim.keymap.set({'n', 'v'}, '<Leader>Dh', function() widgets.hover() end)
    vim.keymap.set({'n', 'v'}, '<Leader>Dp', function() widgets.preview() end)
    vim.keymap.set('n', '<Leader>Df', function() widgets.centered_float(widgets.frames) end)
    vim.keymap.set('n', '<Leader>Ds', function() widgets.centered_float(widgets.scopes) end)
    -- stylua: ignore end
    vim.fn.sign_define('DapBreakpoint', { text = vim.__icons.circle, texthl = 'DiagnosticError' })

    local mason_path = vim.fn.stdpath 'data' .. '/mason/packages'

    require('dap-vscode-js').setup {
      debugger_path = mason_path .. '/js-debug-adapter',
      debugger_cmd = { 'js-debug-adapter' },
      adapters = { 'pwa-node' }, -- which adapters to register in nvim-dap
    }
    dap.adapters.chrome = {
      type = 'executable',
      command = 'node',
      args = { mason_path .. '/chrome-debug-adapter/out/src/chromeDebug.js' },
    }
    for language in vim.iter { 'typescriptreact', 'javascriptreact' } do
      dap.configurations[language] = { chrome_config }
    end
    for language in vim.iter { 'typescript', 'javascript' } do
      dap.configurations[language] = {
        chrome_config,
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Launch file',
          program = '${file}',
          cwd = '${workspaceFolder}',
        },
        {
          type = 'pwa-node',
          request = 'attach',
          name = 'Attach',
          port = 9222,
          sourceMaps = true,
          processId = require('dap.utils').pick_process,
          cwd = '${workspaceFolder}',
        },
      }
    end
  end,
}
