vmap <silent> <F8> :call Ruby_eval()<CR>
nmap <silent> <F8> mzggVG<F8>`z
imap <silent> <F8> <Esc><F8>a

function! Ruby_eval() range
  let src = tempname()
  let dst = tempname()
  execute ": " . a:firstline . "," . a:lastline . "w " . src
  execute ":silent ! $HOME/.rvm/bin/ruby " . src . " > " . dst . " 2>&1 "
  execute ":!mvim " . dst
endfunction

au BufRead,BufNewFile Capfile,Gemfile,Rakefile,Guardfile,config.ru,*.pdf.prawn setfiletype ruby
au BufNewFile,BufRead *.pdf.erb,*.html.erb let b:eruby_subtype='html'
au BufNewFile,BufRead *.pdf.erb set filetype=eruby
