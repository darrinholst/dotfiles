nnoremap <silent> <M-Down> :call DownHorizontal()<CR>
nnoremap <silent> <M-Up> :call UpHorizontal()<CR>
nnoremap <silent> <M-Right> :call RightVertical()<CR>
nnoremap <silent> <M-Left> :call LeftVertical()<CR>

func! DownHorizontal()
  let currentWin = winnr()
  "If no window below or above leave as is, otherwise call function
  wincmd j
  if winnr() == currentWin
    wincmd k
    if winnr() == currentWin
      wincmd k
    else
      exe currentWin . "wincmd w"
      call DownHorizontalAdjust()
    endif
  else
    exe currentWin . "wincmd w"
    call DownHorizontalAdjust()
  endif
endfun

func! DownHorizontalAdjust()
  let currentWin = winnr()
  "If very bottom window, decrease window size, otherwise just increase current window size
  wincmd j
  if winnr() == currentWin
    resize -3
  else
    exe currentWin . "wincmd w"
    resize +3
  endif
endfun

func! UpHorizontal ()
  let currentWin = winnr()
  "If no window below or above leave as is
  wincmd j
  if winnr() == currentWin
    wincmd k
    if winnr() == currentWin
      wincmd k
    else
      exe currentWin . "wincmd w"
      call UpHorizontalAdjust()
    endif
  else
    exe currentWin . "wincmd w"
    call UpHorizontalAdjust()
  endif
endfun

func! UpHorizontalAdjust()
  let currentWin = winnr()
  "If very top window, decrease window size, otherwise just increase current window size
  wincmd k
  if winnr() == currentWin
    resize -3
  else
    resize -3
    exe currentWin . "wincmd w"
  endif
endfun

func! RightVertical()
  let currentWin = winnr()
  " If very right window, decrease window size, otherwise just increase current window size
  wincmd l
  if winnr() == currentWin
    vertical resize -3
  else
    exe currentWin . "wincmd w"
    vertical resize +3
  endif
endfun

func! LeftVertical()
  let currentWin = winnr()
  " If very left window, decrease window size, otherwise just increase current window size
  wincmd h
  if winnr() == currentWin
    vertical resize -3
  else
    vertical resize -3
    exe currentWin . "wincmd w"
  endif
endfun

