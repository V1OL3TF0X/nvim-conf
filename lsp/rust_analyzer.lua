return {
  settings = {
    ['rust-analyzer'] = {
      diagnostics = { enable = true },
      check = {
        command = 'clippy',
      }
    }
  }
}
