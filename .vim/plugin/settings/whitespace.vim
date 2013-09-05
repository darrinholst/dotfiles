command! StripTrailingWhitespaces :call <SID>StripTrailingWhitespaces()

function! <SID>StripTrailingWhitespaces()
  let _s=@/
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  let @/=_s
  call cursor(l, c)
endfunction

augroup cleanup_files
  au!
  au BufWritePre *.scss,*.less,*.css,*.coffee,*.html.*,*.json,*.js,*.rb,*.feature,*.erb :call <SID>StripTrailingWhitespaces()
  au BufWritePre *.scss,*.less,*.css,*.coffee,*.html.*,*.json,*.js,*.rb,*.feature retab!
augroup END
