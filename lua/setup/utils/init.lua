-- credit: https://github.com/ngpong
do
  vim.__lazy = require 'setup.utils.lazy'
  vim.__class = vim.__lazy.require 'setup.utils.oop'
  vim.__bouncer = vim.__lazy.require 'setup.utils.debounce'
  vim.__str = vim.__lazy.require 'setup.utils.str'
  vim.__path = vim.__lazy.require 'setup.utils.path'
  vim.__cache = vim.__lazy.require 'setup.utils.lrucache'
  vim.__autocmd = vim.__lazy.require 'setup.utils.autocmd'
  vim.__filter = vim.__lazy.require 'setup.utils.filter'
  vim.__buf = vim.__lazy.require 'setup.utils.buf'
  vim.__win = vim.__lazy.require 'setup.utils.win'
  vim.__cursor = vim.__lazy.require 'setup.utils.cursor'
end
