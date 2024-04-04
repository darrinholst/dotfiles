local yella = "#b7bc72"
local angry_orange = "#de935f"
local devil_grey = "#666666"
local background = "#1d1f21"

local function hi(name, val)
  vim.api.nvim_set_hl(0, name, val)
end

-- hi("GitSignsAdd", { bg = background, fg = "#b5bd68" })
-- hi("GitSignsChange", { bg = background, fg = "#81a2be" })
-- hi("GitSignsDelete", { bg = background, fg = "#cc6666" })

hi("@comment", { link = "Comment" })
hi("@function.builtin", { link = "@function" })
hi("@variable.builtin", { link = "@variable" })
hi("CursorLineNr", { bg = background, fg = yella, bold = true })
hi("DiagnosticUnderlineHint", { link = "SpellBad" })
hi("EndOfBuffer", { fg = background })
hi("LineNr", { bg = background, fg = devil_grey })
hi("MatchParen", { bg = angry_orange, fg = "black" })
hi("NeoTreeGitUnstaged", { link = "NeoTreeGitModified" })
hi("NeoTreeGitUntracked", { link = "NeoTreeGitModified" })
hi("NeoTreeRootName", { link = "NeoTreeFileNameOpened" })
hi("SignColumn", { bg = background })
hi("SpellBad", { sp = devil_grey, undercurl = true })
hi("TSTypeBuiltin", { fg = yella, bg = background })
hi("TelescopeNormal", { bg = "#222222" })
hi("TelescopePreviewBorder", { link = "TelescopePromptBorder" })
hi("TelescopePreviewLine", { bg = yella, fg = "black" })
hi("TelescopePreviewTitle", { link = "TelescopePromptTitle" })
hi("TelescopePromptBorder", { fg = "white" })
hi("TelescopePromptBorder", { link = "TelescopePromptTitle" })
hi("TelescopePromptNormal", { link = "TelescopePromptTitle" })
hi("TelescopePromptPrefix", { link = "TelescopePromptTitle" })
hi("TelescopePromptTitle", { bg = "#444444" })
hi("TelescopePromptTitle", { bg = background, fg = "#999999" })
hi("TelescopeResultsBorder", { link = "TelescopePromptBorder" })
hi("TreesitterContext", { bg = "#191919" })
hi("VertSplit", { bg = "NONE", fg = devil_grey })
hi("Visual", { bg = yella, fg = "black" })
