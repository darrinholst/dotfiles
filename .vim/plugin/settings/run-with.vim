let ft_stdout_mappings = {
      \'bash': 'bash',
      \'javascript': 'node',
      \'nodejs': 'node',
      \'python': 'python3',
      \'ruby': 'ruby',
      \'sh': 'sh'
      \}

for ft_name in keys(ft_stdout_mappings)
  execute 'autocmd Filetype ' . ft_name . ' nnoremap <buffer> <F8> :write !' . ft_stdout_mappings[ft_name] . '<CR>'
endfor

imap <silent> <F8> <Esc><F8>

