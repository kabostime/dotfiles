set shell=/bin/bash
set nocompatible
set encoding=utf-8
filetype off

if(has('win32'))
  set rtp+=$HOME\.vim\bundle\Vundle.vim
else
  set rtp+=~/.vim/bundle/Vundle.vim
endif
"***************************
" vundle
"***************************
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

"github/vim-scripts
Plugin 'taglist.vim'

"
" other github plugins
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'altercation/vim-colors-solarized'
Plugin 'kchmck/vim-coffee-script'
Plugin 'neocomplcache'
Plugin 'pig.vim'
Plugin 'thinca/vim-quickrun'
Plugin 'donnut/vim-php54-syntax'
Plugin 'scrooloose/syntastic'
Plugin 'joonty/vdebug'
Plugin 'vim-ruby/vim-ruby'

call vundle#end()
syntax enable
filetype plugin indent on
"***************************
" file format
"***************************
" internal encoding
let &termencoding = &encoding
set fileencodings=utf-8,cp932,euc-jp
" enable mode line (e.g. // vim: set expandtab ff=unix : )
set modeline

" ◇とかの記号があってもカーソル位置がずれないようにする
set ambiwidth=double

"***************************
" tab
"***************************
" tab を スペースで代用
set expandtab
"シフト移動幅
set shiftwidth=4
"行頭の余白内で Tab を打ち込むと、'shiftwidth' の数だけインデントする。
set smarttab
"ファイル内の <Tab> が対応する空白の数
set tabstop=4

"***************************
" view
"***************************
let g:solarized_termtrans=1
set t_Co=256
set background=dark
colorscheme solarized


"***************************
" editor
"***************************
"音鳴らないようにする
set visualbell
"新しい行のインデントを現在行と同じにする
set autoindent
set smartindent
"インクリメンタルサーチを行う
set incsearch
"検索で大文字小文字を区別しない
set ignorecase
"検索結果のハイライト
set hlsearch
"listで表示される文字のフォーマットを指定する
set list
set listchars=tab:>-,extends:$
"行番号を表示する
set number
"閉じ括弧が入力されたとき、対応する括弧を表示する
set showmatch
"検索時に大文字を含んでいたら大/小を区別
set smartcase
"新しい行を作ったときに高度な自動インデントを行う
set smartindent
"カーソルを行頭、行末で止まらないようにする
set whichwrap=b,s,h,l,<,>,[,]
"検索をファイルの先頭へループしない
set nowrapscan
"賢いステータスライン
set laststatus=2
set statusline=%<%f\ %m\ %r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=\ (%v,%l)/%L%8P\ 
"全角スペースを視覚化
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=#666666
if(has('win32'))
    au BufNewFile,BufRead * match ZenkakuSpace /\%u8140/
else
    au BufNewFile,BufRead * match ZenkakuSpace /　/
endif
"入力モード時、ステータスラインのカラーを変更
augroup InsertHook
au!
au InsertEnter * highlight StatusLine guifg=#ccdc90 guibg=#2E4340
au BufnewFile,BufRead,InsertLeave * highlight StatusLine guifg=#2E4340 guibg=#ccdc90
augroup END

"***************************
" buffer
"***************************
"クリップボードをWindowsと連携
set clipboard=unnamed

"***************************
" backup
"***************************
"スワップファイル用のディレクトリ(スペースは使えないよぉ)
if(has('win32'))
    set directory=$HOME\.vim\swap
else
    set directory=$HOME/.vim/swap
endif
set nobackup
set nowritebackup
set swapfile

"***************************
" etc
"***************************
"ディレクトリ閲覧時の表示をツリー形式に
let g:netrw_liststyle=3

" 開いてるファイルと同じディレクトリをカレントディレクトリに
au BufEnter * execute ":lcd " . expand("%:p:h")

"***************************
" coffee
"***************************
au BufNewFile,BufRead,BufReadPre *.coffee set filetype=coffee 
autocmd FileType coffee setlocal noet ts=2 sw=2 sts=2

"***************************
" php
"***************************
" php の折りたたみ
let php_folding=1
au Syntax php set fdm=syntax

autocmd FileType php set tabstop=2
autocmd FileType php set shiftwidth=2
autocmd FileType php set noet

"***************************
" pig
"***************************
augroup filetypedetect 
	au BufNewFile,BufRead *.pig set filetype=pig syntax=pig 
augroup END 
"***************************
" ruby
"***************************
au BufNewFile,BufRead *.rb  set nowrap tabstop=2 shiftwidth=2
"***************************
" as
"***************************
au BufNewFile,BufRead *.as  set filetype=actionscript


"***************************
" plugin settings
"***************************
"
" --- vdebug ---
let g:vdebug_options = {'break_on_open' : 1, 'port' : 9000, 'server' : '192.168.33.11' }
" --- taglist ---
set tags=tags

" --- neocomplecache ---
"起動時に有効化
let g:acp_enableAtStartup = 0
let g:neocomplecache_enable_at_startup = 1
"大文字小文字の区別を無視
let g:neocomplecache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
"アンダーバーをうまい具合に
let g:neocomplecache_enable_underbar_completion = 1

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
    let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'

" key-mappings.
" 辞書読み込み
noremap  <Space>d. :<C-u>NeoComplCacheCachingDictionary<Enter>
" <TAB> completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
" C-jでオムニ補完
inoremap <expr> <C-j> &filetype == 'vim' ? "\<C-x>\<C-v>\<C-p>" : "\<C-x>\<C-o>\<C-p>"
" C-kを押すと行末まで削除
inoremap <C-k> <C-o>D
" C-nでneocomplcache補完
inoremap <expr><C-n>  pumvisible() ? "\<C-n>" : "\<C-x>\<C-u>\<C-p>"
" C-pでkeyword補完
inoremap <expr><C-p> pumvisible() ? "\<C-p>" : "\<C-p>\<C-n>"
" 補完候補が表示されている場合は確定。そうでない場合は改行
inoremap <expr><CR>  pumvisible() ? neocomplcache#close_popup() : "<CR>"
" 補完をキャンセル
inoremap <expr><C-e>  neocomplcache#close_popup()
