return {
  on_attach = require 'virtualtypes'.on_attach,
  settings = {
    ['rust-analyzer'] = {
      check = {
        command = 'clippy',
      }
    }
  }
}
