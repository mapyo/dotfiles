"--------------------------------------------------------------------------
" neobundle
set nocompatible               " Be iMproved
filetype off                   " Required!

" neobundle settings {{{
if has('vim_starting')
  set nocompatible
  " neobundle をインストールしていない場合は自動インストール
  if !isdirectory(expand("~/.vim/bundle/neobundle.vim/"))
    echo "install neobundle..."
    " vim からコマンド呼び出しているだけ neobundle.vim のクローン
    :call system("git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim")
  endif
  " runtimepath の追加は必須
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

set runtimepath+=~/.vim/puppet-syntax-vim/syntax/puppet.vim


call neobundle#begin(expand('~/.vim/bundle'))
let g:neobundle_default_git_protocol='https'



NeoBundleFetch 'Shougo/neobundle.vim'


"GitHubリポジトリにあるプラグインを利用場合
"http://qiita.com/hyshhryk/items/4936c4412daa866daf7d
NeoBundle 'tpope/vim-fugitive'
"GitHub以外のGitリポジトリにあるプラグインを利用する場合
" vimを立ち上げる度に何度もインストールを聞いてくるのでコメントアウトする
" NeoBundle 'https://git.wincent.com/command-t.git'
"補完
NeoBundle 'Shougo/neocomplcache.vim'
NeoBundle 'kien/ctrlp.vim' " ファイル開く時にctrl-pで開ける便利なやつ。
NeoBundle 'https://github.com/Shougo/unite.vim.git' " unite!!!
NeoBundle 'Shougo/neomru.vim' " 履歴を見る時にどうやら必要っぽい
NeoBundle 'tell-k/vim-browsereload-mac' "vimで保存した時に自動的にブラウザをリロードしてくれるやつ。
NeoBundle 'surround.vim' "タグの編集をやりやすくしてくれるやつ
NeoBundle 'Shougo/vimfiler' "vimfiler
NeoBundle 'mattn/zencoding-vim' " 使えなかった。。。
NeoBundle 'vim-scripts/vim-auto-save' " 自動的に保存する
NeoBundle 'scrooloose/syntastic' " シンタックスチェック
NeoBundle 'osyo-manga/vim-over'
NeoBundle 'thinca/vim-quickrun' " すぐコンパイル出来るやつ
NeoBundle 'Align' "下のやつを使うためのプラグイン
NeoBundle 'vim-scripts/SQLUtilities' " sqlの整形など
NeoBundle 'rodjek/vim-puppet' " puppetファイルの整形
NeoBundle '2072/PHP-Indenting-for-VIm' " vimでphpのインデント調整をいい感じに
NeoBundle 'airblade/vim-gitgutter' " vimでgitの差分を表示
NeoBundle 'stephpy/vim-php-cs-fixer' " php-cs-fixerをvimで
NeoBundle 'tomtom/tcomment_vim' " コメントアウト http://qiita.com/alpaca_taichou/items/211cd62bee84c59ca480
NeoBundle 'mattn/emmet-vim' " emmet-vim http://qiita.com/muran001/items/9ce24525b3285678acc3
NeoBundle 'vim-scripts/matchit.zip' " 対応するhtmlタグへ移動 http://blog.thrbrd.com/plugin/howto-matchit.html
NeoBundle 'derekwyatt/vim-scala' " scala syntax highlight
NeoBundle 'PDV--phpDocumentor-for-Vim' " phpdocumentor http://mofumofu3n.hatenablog.jp/entry/2013/09/22/052351
NeoBundle 'godlygeek/tabular' " tabular
NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\     'mac' : 'make -f make_mac.mak',
\    },
\ } " quickrunを非同期に実行する為
NeoBundle 'leafgarland/typescript-vim' " typescript
" NeoBundle 'clausreinke/typescript-tools' " typescript
NeoBundle 'jason0x43/vim-js-indent' " typescriptでインデントされない
NeoBundle 'nginx.vim' " ref. http://blog.glidenote.com/blog/2012/04/08/nginx.vim/
NeoBundle 'nanotech/jellybeans.vim'
" http://qiita.com/alpaca_taichou/items/fb442cfa78f91634cfaa
" syntax + 自動compile
NeoBundle 'kchmck/vim-coffee-script'
" js BDDツール
NeoBundle 'claco/jasmine.vim'
" indentの深さに色を付ける
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'posva/vim-vue'


NeoBundleCheck
call neobundle#end()

filetype plugin indent on     " Required!
""" for jellybeans
set t_Co=256
syntax on
colorscheme jellybeans

""" for nginx.vim
au BufRead,BufNewFile nginx.conf set ft=nginx

""" for typescript
au BufRead,BufNewFile,BufReadPre *.ts  set filetype=typescript
autocmd FileType typescript setlocal sw=4 sts=4 ts=4 et


""" for PDV--phpDocumentor-for-Vim
""" http://mofumofu3n.hatenablog.jp/entry/2013/09/22/052351
nnoremap <silent>,pd :call PhpDocSingle()<CR>


""" for git-browse
command! -nargs=* -range GB !git browse-remote --rev -L<line1>,<line2> <f-args> -- %


""""" for coffee
" http://qiita.com/alpaca_taichou/items/fb442cfa78f91634cfaa
" vimにcoffeeファイルタイプを認識させる
au BufRead,BufNewFile,BufReadPre *.coffee   set filetype=coffee
" " インデントを設定
autocmd FileType coffee     setlocal sw=2 sts=2 ts=2 et


"------------------------------------
" jasmine.vim
"------------------------------------
" ファイルタイプを変更
function! JasmineSetting()
  au BufRead,BufNewFile *Helper.js,*Spec.js  set filetype=jasmine.javascript
  au BufRead,BufNewFile *Helper.coffee,*Spec.coffee  set filetype=jasmine.coffee
  au BufRead,BufNewFile,BufReadPre *Helper.coffee,*Spec.coffee  let b:quickrun_config = {'type' : 'coffee'}
  call jasmine#load_snippets()
  map <buffer> <leader>m :JasmineRedGreen<CR>
  command! JasmineRedGreen :call jasmine#redgreen()
  command! JasmineMake :call jasmine#make()
endfunction
au BufRead,BufNewFile,BufReadPre *.coffee,*.js call JasmineSetting()

"------------------------------------
" quickrun vimproc でPHPUnitを非同期実行する
" http://www.karakaram.com/quickrun-phpunit
"------------------------------------
" augroup QuickRunPHPUnit
"   autocmd!
"   autocmd BufWinEnter,BufNewFile *Test.php set filetype=php.unit
" augroup END
"
" let g:quickrun_config = {}
" let g:quickrun_config['_'] = {}
" let g:quickrun_config['_']['runner'] = 'vimproc'
" let g:quickrun_config['_']['runner/vimproc/updatetime'] = 100
"
" let g:quickrun_config['php.unit'] = {}
" let g:quickrun_config['php.unit']['outputter/buffer/split'] = 'vertical 35'
" let g:quickrun_config['php.unit']['command'] = 'phpunit'
" let g:quickrun_config['php.unit']['cmdopt'] = ''
" let g:quickrun_config['php.unit']['exec'] = '%c %o %s'




"------------------------------------
" indent_guides
"------------------------------------
" インデントの深さに色を付ける
let g:indent_guides_start_level=2
let g:indent_guides_auto_colors=0
let g:indent_guides_enable_on_vim_startup=0
let g:indent_guides_color_change_percent=20
let g:indent_guides_guide_size=1
let g:indent_guides_space_guides=1

hi IndentGuidesOdd  ctermbg=235
hi IndentGuidesEven ctermbg=237
" 以下、エラーになる
" au FileType coffee,ruby,javascript,python IndentGuidesEnable
nmap <silent><Leader>ig <Plug>IndentGuidesToggle


" tomtom/tcomment_vim
" gccや選択してgcでコメントアウトしてくれる
" http://lsifrontend.hatenablog.com/entry/2013/10/11/052640
nmap <silent> <C-Enter> yy:<C-u>TComment<CR>p

" ステータスラインを表示させる
set laststatus=2
" ステータスラインに現在の行も文字数を表示
set statusline=%-(%f%m%h%q%r%w%)%=%{&ff}\|%{&fenc}\ %y%l,%c\ %0P

" vim-php-cs-fixer
let g:php_cs_fixer_path = "/usr/local/bin/php-cs-fixer"
" nnoremap <silent>,pcd :call PhpCsFixerFixDirectory()<CR>
" 現在のファイルのみ修正するようにする
nnoremap <silent>,pc :call PhpCsFixerFixFile()<CR>

" vimでgitの差分を表示
" airblade/vim-gitgutter
nnoremap <silent> ,gg :<C-u>GitGutterToggle<CR>
nnoremap <silent> ,gh :<C-u>GitGutterLineHighlightsToggle<CR>

" quickrun
nnoremap <silent> \r :QuickRun -cmdopt "<CR>

" vimでphpのインデントいい感じに
" 2072/PHP-Indenting-for-VIm
let g:PHP_vintage_case_default_indent = 1

" カレントウィンドウにのみ罫線を引く
" todo:動いてない？？
augroup cch
    autocmd! cch
    autocmd WinLeave * set nocursorline
    autocmd WinEnter,BufRead * set cursorline
augroup END

hi clear CursorLine
hi CursorLine gui=underline
highlight CursorLine ctermbg=black guibg=black

" 不可視文字を見れるようにする
set list
" 不可視文字の表示形式
set listchars=tab:>.,trail:_,extends:>,precedes:<

" 括弧の対応をハイライト
set showmatch

" バックアップファイルを作成しない。
set nobackup
" スワップファイルを作らない
set noswapfile


" syntastic
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=2

" vim-auto-save
" https://github.com/vim-scripts/vim-auto-save/blob/master/README.md
let g:auto_save=1 " 自動保存を有効にする
let g:auto_save_in_insert_mode = 0 " insertモードでの自動保存をしない
let g:auto_save_silent = 1 " autosaveしたというメッセージを毎回出さない

"""""" neocomplcache start
let g:NeoComplCache_EnableAtStartup=1
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : ''
    \ }

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()
"""""" neocomplcache end

" ReLoad .vimrc
nmap <Space>rv :source ~/.vimrc <CR>

" vim-browsereload-mac
" リロード後に戻ってくるアプリ 変更してください
" let g:returnApp = "MacVim"
let g:returnApp = "iTerm"
nmap <Space>bc :ChromeReloadStart<CR>
nmap <Space>bC :ChromeReloadStop<CR>
nmap <Space>bf :FirefoxReloadStart<CR>
nmap <Space>bF :FirefoxReloadStop<CR>

"""" uniteを使うためのキーバインド
" ファイル一覧
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" 最近使用したファイル一覧
nnoremap <silent> ,um :<C-u>Unite file_mru<CR>
" grep検索
nnoremap <silent> ,ug :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
" ヤンク履歴を表示
nnoremap <silent> ,y :<C-u>Unite -buffer-name=register register<CR>

""" var_dumpを打つのがめんどくさい
nnoremap <silent> ,vd ivar_dump();<Esc>


" コピーした時にクリップボードに入れる
" macvimでしか動いていない
set clipboard=unnamed

"タブ関係の設定start
set expandtab "タブ入力を複数の空白入力に置き換える
set tabstop=4 "画面上でタブ文字が占める幅
set shiftwidth=4 "自動インデントでずれる幅
" ↑ファイルによって使い分ける

"set softtabstop=2 "連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set autoindent "改行時に前の行のインデントを継続する
set smartindent "改行時に入力された行の末尾に合わせて次の行のインデントを増減する
"タブ関係の設定end


"行番号を表示する
set number
"新しい行のインデントを現在行と同じにする
set autoindent

set history=100" keep 50 lines of command line history

" Don't use Ex mode, use Q for formatting
map Q gq

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

"検索時にファイルの最後まで行ったら最初に戻らないようにする
set nowrapscan

"自動改行をoff
set tw=0

" 絶対に自動改行しない
set formatoptions=q

" カーソルの上または下に表示させる最小の行数
set scrolloff=5

set encoding=utf-8
set fileencodings=utf-8,euc-jp,ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,sjis,cp932

" スペース　ドットでvimrcを開けるように設定
nnoremap <Space>. :<C-u>tabedit $MYVIMRC<CR>

" Jsonのいい感じにformatしてくれる。
" todo:順番が変わってしまうので、変わらない何か
command! JsonFormat :execute ':%!python -m json.tool'

" 最後に開いたファイルの行に移動してくれる
augroup vimrcEx
    au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
    \ exe "normal g`\"" | endif
augroup END

" scalaのfiletypeを自動認識
au BufNewFile,BufRead *.scala setf scala " *.scala ファイルを開く時、filetypeを設定する


" for go
set rtp+=$GOROOT/misc/vim
exe "set rtp+=".globpath($GOPATH, "src/github.com/nsf/gocode/vim")
set completeopt=menu,preview
