local dap = require('dap')
require('dapui').setup()

vim.fn.sign_define('DapBreakpoint', { text = '🔴', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapBreakpointRejected', { text = '❓', texthl = '', linehl = '', numhl = '' })

dap.adapters.node = {
  type = 'executable',
  command = os.getenv('HOME') .. '/.local/share/nvim/mason/bin/node-debug2-adapter'
}

dap.adapters.sh = {
  type = 'executable',
  command = 'bash-debug-adapter',
}

dap.configurations.sh = {
  {
    args = {},
    argsString = '',
    cwd = vim.fn.getcwd(),
    env = {},
    name = 'Launch',
    pathBash = '/opt/homebrew/bin/bash',
    pathBashdb = '/opt/homebrew/bin/bashdb',
    pathBashdbLib = '/opt/homebrew/share/bashdb/',
    pathCat = '/bin/cat',
    pathMkfifo = '/usr/bin/mkfifo',
    pathPkill = '/usr/bin/pkill',
    program = '${file}',
    request = 'launch',
    showDebugOutput = false,
    terminalKind = 'integrated',
    trace = true,
    type = 'sh',
  },
}

dap.configurations.javascript = {
  {
    name = 'Run script',
    type = 'node',
    request = 'launch',
    runtimeExecutable = 'npm',
    runtimeArgs = function()
      return { 'run-script', vim.fn.input('Which script: ') }
    end,
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
  },
  {
    name = 'Launch',
    type = 'node',
    request = 'launch',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
  },
  {
    name = 'Attach to process',
    type = 'node',
    request = 'attach',
    processId = require 'dap.utils'.pick_process,
  },
}
