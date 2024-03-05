require("yanky").setup({
  highlight = {
    on_put = false,
    on_yank = false,
  },
})
require("telescope").load_extension("yank_history")
