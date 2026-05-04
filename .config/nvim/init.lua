local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end

vim.opt.rtp:prepend(lazypath)

require("my.settings")
require("lazy").setup("my.plugins", {
  ui = {
    border = "rounded",
  },
})
require("my.keymaps")
require("my.highlights")
require("my.diagnostics")
