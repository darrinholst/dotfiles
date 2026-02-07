local function apply_highlights()
  local ok, palette = pcall(function()
    return require("catppuccin.palettes").get_palette()
  end)

  if not ok then return end

  local normal_hl = vim.api.nvim_get_hl(0, { name = "Normal" })
  local background = normal_hl.bg and string.format("#%06x", normal_hl.bg) or "NONE"

  local function hi(name, val)
    vim.api.nvim_set_hl(0, name, val)
  end

  hi("@comment", { link = "Comment" })
  hi("@function.builtin", { link = "@function" })
  hi("@type.builtin", { fg = palette.yellow, bg = background })
  hi("@variable.builtin", { link = "@variable" })
  hi("CursorLineNr", { bg = background, fg = palette.yellow, bold = true })
  hi("DiagnosticUnderlineHint", { link = "SpellBad" })
  hi("EndOfBuffer", { fg = background })
  hi("FloatBorder", { fg = palette.overlay0, bg = background })
  hi("LineNr", { bg = background, fg = palette.overlay0 })
  hi("MatchParen", { bg = palette.peach, fg = palette.base })
  hi("NeoTreeNormal", { bg = background })
  hi("NeoTreeNormalNC", { bg = background })
  hi("NeoTreeWinSeparator", { fg = palette.overlay0, bg = background })
  hi("NeoTreeGitUnstaged", { link = "NeoTreeGitModified" })
  hi("NeoTreeGitUntracked", { link = "NeoTreeGitModified" })
  hi("NeoTreeRootName", { link = "NeoTreeFileNameOpened" })
  hi("NormalFloat", { bg = background })
  hi("SignColumn", { bg = background })
  hi("SpellBad", { sp = palette.overlay0, undercurl = true })
  hi("TreesitterContext", { bg = palette.surface0 })
  hi("Visual", { bg = palette.yellow, fg = palette.base })
  hi("WinSeparator", { bg = "NONE", fg = palette.overlay0 })
end

apply_highlights()

vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("my-highlights", { clear = true }),
  callback = apply_highlights,
})
