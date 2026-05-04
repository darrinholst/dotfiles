return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  dependencies = {
    { "nvim-treesitter/nvim-treesitter-textobjects", branch = "main" },
    "nvim-treesitter/nvim-treesitter-context",
  },
  config = function()
    require("nvim-treesitter").setup()

    require("nvim-treesitter").install({
      "bash",
      "html",
      "lua",
      "markdown",
      "markdown_inline",
      "vim",
      "vimdoc",
      "hcl",
      "terraform",
      "javascript",
      "json",
      "typescript",
      "tsx",
    })

    require("nvim-treesitter-textobjects").setup {
      select = {
        lookahead = true,
      },
    }

    vim.keymap.set({ "x", "o" }, "af", function()
      require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
    end)
    vim.keymap.set({ "x", "o" }, "if", function()
      require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
    end)

    require("treesitter-context").setup()

    local selection_stack = {}

    local function select_node(node)
      local sr, sc, er, ec = node:range()
      vim.fn.setpos("'<", { 0, sr + 1, sc + 1, 0 })
      vim.fn.setpos("'>", { 0, er + 1, ec, 0 })
      vim.cmd("normal! gv")
    end

    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        if not pcall(vim.treesitter.start, args.buf) then return end

        vim.keymap.set("n", "<CR>", function()
          local node = vim.treesitter.get_node()
          if not node then return end
          selection_stack = { node }
          select_node(node)
        end, { buffer = args.buf, desc = "Init treesitter incremental selection" })

        vim.keymap.set("x", "<CR>", function()
          local current = selection_stack[#selection_stack]
          if not current then return end
          local parent = current:parent()
          if not parent then return end
          table.insert(selection_stack, parent)
          select_node(parent)
        end, { buffer = args.buf, desc = "Increment treesitter selection" })

        vim.keymap.set("x", "<BS>", function()
          if #selection_stack <= 1 then return end
          table.remove(selection_stack)
          local node = selection_stack[#selection_stack]
          if node then select_node(node) end
        end, { buffer = args.buf, desc = "Decrement treesitter selection" })
      end,
    })
  end,
}
