local jet_blue = "#2b60a7"
local yella = "#b7bc72"
local angry_orange = "#de935f"
local devil_grey = "#666666"
local background = "#1d1f21"

local function hi(name, val)
  vim.api.nvim_set_hl(0, name, val)
end

hi("LineNr", { bg = background, fg = devil_grey })
hi("CursorLineNr", { bg = background, fg = yella, bold = true })
hi("SignColumn", { bg = background })
hi("EndOfBuffer", { fg = background })
hi("SpellBad", { sp = devil_grey, undercurl = true })
hi("DiagnosticUnderlineHint", { link = "SpellBad" })
hi("VertSplit", { bg = "NONE", fg = jet_blue })
hi("Visual", { bg = yella, fg = "black" })
hi("MatchParen", { bg = angry_orange, fg = "black" })
hi("TelescopeBorder", { fg = jet_blue })
hi("TelescopeSelection", { bg = jet_blue })
hi("TelescopeMatching", { bg = yella, fg = "black" })
hi("GitSignsAdd", { bg = background, fg = "#b5bd68" })
hi("GitSignsChange", { bg = background, fg = "#81a2be" })
hi("GitSignsDelete", { bg = background, fg = "#cc6666" })
