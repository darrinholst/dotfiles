local dap = require("dap")
require("dapui").setup()

dap.adapters.node = {
  type = "executable",
  command = "node",
  args = { os.getenv("HOME") .. "/.local/share/node-debug2/out/src/nodeDebug.js" },
}

dap.configurations.javascript = {
  {
    name = "Run script",
    type = "node",
    request = "launch",
    runtimeExecutable = "npm",
    runtimeArgs = function()
      return { "run-script", vim.fn.input("Which script: ") }
    end,
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector",
    console = "integratedTerminal",
  },
  {
    name = "Launch",
    type = "node",
    request = "launch",
    program = "${file}",
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector",
    console = "integratedTerminal",
  },
  {
    name = "Attach to process",
    type = "node",
    request = "attach",
    processId = require "dap.utils".pick_process,
  },
}
