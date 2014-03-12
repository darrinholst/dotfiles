function MapVimSmallsKeys()
  unmap s
  nmap s <Plug>(smalls)
endfunction

autocmd VimEnter * call MapVimSmallsKeys()

