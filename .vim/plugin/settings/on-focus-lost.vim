" get the eff out of insert mode on foucs lost
:au FocusLost,TabLeave * call feedkeys("\<C-\>\<C-n>")

" auto save files
:au FocusLost * :call SaveAll()

function! SaveAll()
  try
    wa
  catch
    " ignore
  endtry
endfunction

