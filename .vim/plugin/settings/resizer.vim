"By default I have the windows adjustment functions set to <Ctrl+j> for down, <Ctrl+k> for up, <Ctrl+l> for right & <Ctrl +h> for left
"Adjust them to whatever suits your needs

"noremap <silent> <S-Up> 5<C-W>+
"noremap <silent> <S-Down> 5<C-W>-
"noremap <silent> <S-Left> 5<C-W><
"noremap <silent> <S-Right> 5<C-W>>
"
nnoremap <silent> <S-Down> :call DownHorizontal()<CR>
nnoremap <silent> <S-Up> :call UpHorizontal()<CR>
nnoremap <silent> <S-Right> :call RightVertical()<CR>
nnoremap <silent> <S-Left> :call LeftVertical()<CR>


"WINDOW RESIZING Down
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
   resize -1
else
   exe currentWin . "wincmd w"
   resize +1
endif
endfun


"WINDOW RESIZING Up
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
      resize -1
   else
      resize -1
      exe currentWin . "wincmd w"
endif
endfun


"WINDOW RESIZING Right (only requires 1 function)
func! RightVertical()
let currentWin = winnr()
" If very right window, decrease window size, otherwise just increase current window size
wincmd l
if winnr() == currentWin
   vertical resize -1
else
  exe currentWin . "wincmd w"
  vertical resize +1
endif
endfun


"WINDOW RESIZING Left (only requires 1 function)
func! LeftVertical()
let currentWin = winnr()
" If very left window, decrease window size, otherwise just increase current window size
wincmd h
if winnr() == currentWin
   vertical resize -1
else
  vertical resize -1
  exe currentWin . "wincmd w"
endif
endfun

