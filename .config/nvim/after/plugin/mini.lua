require('mini.ai').setup();
require('mini.cursorword').setup();

_G.cursorword_blocklist = function()
  local disabled_filetypes = { 'fugitive', 'NvimTree', 'TelescopePrompt' }
  local filetype = vim.api.nvim_buf_get_option(0, 'filetype')

  if (vim.tbl_contains(disabled_filetypes, filetype)) then
    vim.b.minicursorword_disable = true
    return
  end

  local curword = vim.fn.expand('<cword>')
  local blocklist = {}

  if filetype == 'lua' then
    blocklist = { 'local', 'require' }
  elseif vim.tbl_contains({ 'javascript', 'javascriptreact' }, filetype) then
    blocklist = { 'import', 'require', 'const', 'let' }
  end

  vim.b.minicursorword_disable = vim.tbl_contains(blocklist, curword)
end

vim.cmd('au CursorMoved * lua _G.cursorword_blocklist()')
