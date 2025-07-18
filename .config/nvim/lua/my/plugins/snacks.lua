return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    input = { enabled = true },
    picker = {
      enabled = true,

      layout = {
        preset = function() return vim.o.columns >= 150 and "default" or "vertical" end,
      },
    },
    statuscolumn = { enabled = true },
    gitbrowse = { enabled = true },
  },
  keys = {
    { "<C-p>", function() Snacks.picker.smart { hidden = true } end, desc = "Smart Find Files" },
    { "<C-g>", function()
      Snacks.picker.grep {
        hidden = true,
      }
    end, desc = "Grep" },
    {
      "<leader>gw",
      function() Snacks.picker.grep_word { hidden = true } end,
      desc = "Visual selection or word",
      mode = { "n", "x" },
    },
    {
      "<C-e>",
      function()
        Snacks.picker.buffers {
          current = false,
          sort_lastused = true,
          layout = { preview = false, preset = "select" },
        }
      end,
      desc = "Buffers",
    },
    { "<C-b>", function() Snacks.picker.lines() end, desc = "Buffer Lines" },

    { "<space>o", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
    { "<leader>ds", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
    { "<leader>ws", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
    { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
    { "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
    { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },

    { "<leader>gl", function() Snacks.gitbrowse() end, desc = "Git Browse", mode = { "n", "v" } },

    { '<leader>s"', function() Snacks.picker.registers() end, desc = "Registers" },
    { "<leader>s/", function() Snacks.picker.search_history() end, desc = "Search History" },
    { "<leader>sa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
    { "<leader>sc", function() Snacks.picker.command_history() end, desc = "Command History" },
    { "<leader>sC", function() Snacks.picker.commands() end, desc = "Commands" },
    { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
    { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
    { "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
    { "<leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights" },
    { "<leader>si", function() Snacks.picker.icons() end, desc = "Icons" },
    { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
    { "<leader>sl", function() Snacks.picker.loclist() end, desc = "Location List" },
    { "<leader>sp", function() Snacks.picker.lazy() end, desc = "Search for Plugin Spec" },
    { "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
    { "<leader>sr", function() Snacks.picker.resume() end, desc = "Resume" },
    { "<leader>su", function() Snacks.picker.undo() end, desc = "Undo History" },
    { "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },

    -- Top Pickers & Explorer
    -- { "<leader>n", function() Snacks.picker.notifications() end, desc = "Notification History" },
    -- { "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
    -- find
    -- { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
    -- { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
    -- { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
    -- { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
    -- { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
    -- { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },
    -- git
    -- { "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
    -- { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
    -- { "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
    -- { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
    -- { "<leader>gS", function() Snacks.picker.git_stash() end, desc = "Git Stash" },
    -- { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
    -- { "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },
    -- Grep
    -- { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
    -- LSP
    -- { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
    -- { "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
    -- { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
    -- { "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
    -- { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
    -- Other
    -- { "<leader>z",  function() Snacks.zen() end, desc = "Toggle Zen Mode" },
    -- { "<leader>Z",  function() Snacks.zen.zoom() end, desc = "Toggle Zoom" },
    -- { "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
    -- { "<leader>S",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
    -- { "<leader>n",  function() Snacks.notifier.show_history() end, desc = "Notification History" },
    -- { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
    -- { "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename File" },
    -- { "<c-_>",      function() Snacks.terminal() end, desc = "which_key_ignore" },
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function() end,
    })
  end,
}
