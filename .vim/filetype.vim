if exists("did_load_filetypes")
  finish
endif
augroup filetypedetect
  au BufNewFile,BufRead *.rb     setlocal tabstop=2 shiftwidth=2
  au BufNewFile,BufRead *.pp     setlocal tabstop=2 shiftwidth=2
  au BufNewFile,BufRead *.tpl    setlocal tabstop=2 shiftwidth=2
  au BufNewFile,BufRead *.js     setlocal tabstop=2 shiftwidth=2
  au BufNewFile,BufRead *.coffee setlocal tabstop=2 shiftwidth=2
  au BufNewFile,BufRead *.sh     setlocal tabstop=2 shiftwidth=2
  au BufNewFile,BufRead *.json   setlocal tabstop=2 shiftwidth=2
  au BufNewFile,BufRead *.html   setlocal tabstop=2 shiftwidth=2
  au BufNewFile,BufRead *.yml    setlocal tabstop=2 shiftwidth=2
  au BufNewFile,BufRead *.erb    setlocal tabstop=2 shiftwidth=2
  au BufNewFile,BufRead Rakefile setlocal tabstop=2 shiftwidth=2
  au BufNewFile,BufRead Dockerfile.* setf dockerfile "Dockerfile.*を開く時はdockerfileとして認識させる
augroup END
