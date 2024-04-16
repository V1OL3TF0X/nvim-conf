require('conform').setup {
    formatters_by_ft = {
        javascript = { 'prettier' },
        typescript = { 'prettier' },
        html = { 'prettier' },
        djangohtml = { 'prettier' },
    },
    format_on_save = {
        timeout_ms = 200,
        lsp_fallback = true,
    }
}
