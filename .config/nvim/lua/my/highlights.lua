local function apply_highlights()
  local yella = "#b7bc72"
  local angry_orange = "#de935f"
  local devil_grey = "#666666"
  local normal_hl = vim.api.nvim_get_hl(0, { name = "Normal" })
  local background = normal_hl.bg and string.format("#%06x", normal_hl.bg) or "NONE"

  local function hi(name, val)
    vim.api.nvim_set_hl(0, name, val)
  end

  hi("@comment", { link = "Comment" })
  hi("@function.builtin", { link = "@function" })
  hi("@type.builtin", { fg = yella, bg = background })
  hi("@variable.builtin", { link = "@variable" })
  hi("CursorLineNr", { bg = background, fg = yella, bold = true })
  hi("DiagnosticUnderlineHint", { link = "SpellBad" })
  hi("EndOfBuffer", { fg = background })
  hi("FloatBorder", { fg = devil_grey, bg = background })
  hi("LineNr", { bg = background, fg = devil_grey })
  hi("MatchParen", { bg = angry_orange, fg = "black" })
  hi("NeoTreeNormal", { bg = background })
  hi("NeoTreeNormalNC", { bg = background })
  hi("NeoTreeWinSeparator", { fg = devil_grey, bg = background })
  hi("NeoTreeGitUnstaged", { link = "NeoTreeGitModified" })
  hi("NeoTreeGitUntracked", { link = "NeoTreeGitModified" })
  hi("NeoTreeRootName", { link = "NeoTreeFileNameOpened" })
  hi("NormalFloat", { bg = background })
  hi("SignColumn", { bg = background })
  hi("SpellBad", { sp = devil_grey, undercurl = true })
  hi("TreesitterContext", { bg = "#191919" })
  hi("Visual", { bg = yella, fg = "black" })
  hi("WinSeparator", { bg = "NONE", fg = devil_grey })
end

apply_highlights()

vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("my-highlights", { clear = true }),
  callback = apply_highlights,
})
