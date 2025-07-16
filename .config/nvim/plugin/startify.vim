function! s:gitModified()
  let files = systemlist('git ls-files -m 2>/dev/null')
  return map(files, "{'line': v:val, 'path': v:val}")
endfunction

function! s:gitUntracked()
  let files = systemlist('git ls-files -o --exclude-standard 2>/dev/null')
  return map(files, "{'line': v:val, 'path': v:val}")
endfunction

let g:startify_lists = [
  \ { 'type': function('s:gitModified'),  'header': ['   git modified']},
  \ { 'type': function('s:gitUntracked'), 'header': ['   git untracked']},
  \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
  \ { 'type': 'commands',  'header': ['   Commands']       },
  \ ]

function! ProjectInfo()
  let header = []

  let nvim_version = has('nvim') ? matchstr(execute('version'), 'NVIM v\zs[^\n]*') : v:version

  call add(header, '    ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗')
  call add(header, '    ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║')
  call add(header, '    ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║')
  call add(header, '    ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║')
  call add(header, '    ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║')
  call add(header, '    ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝')
  call add(header, '')
  call add(header, '                        v' . nvim_version)
  call add(header, '')

  call add(header, '   Uptime: ' . system('uptime | cut -d"," -f1 | cut -d" " -f4- | tr -d "\n"'))

  try
    let lazy_stats = luaeval('require("lazy").stats()')
    call add(header, '   Plugins: ' . lazy_stats.count . ' installed, ' . lazy_stats.loaded . ' loaded')
    call add(header, '   Startup: ' . printf('%.2f', lazy_stats.startuptime) . 'ms')
  catch
    " Fallback if lazy.nvim not available
  endtry

  call add(header, '')
  call add(header, '   Path: ' . getcwd())

  let branch = system('git branch --show-current 2>/dev/null | tr -d "\n"')
  if !empty(branch)
    let last_commit = system('git log -1 --pretty=format:"%h %s (%an, %ad)" --date=short 2>/dev/null | tr -d "\n"')
    call add(header, '   Git branch: ' . branch)
    call add(header, '   Last commit: ' . last_commit)
  endif

  return header
endfunction

let g:startify_custom_header = ProjectInfo()
