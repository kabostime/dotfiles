"***************************
" vundle
"***************************
set nocompatible
filetype off

if (has('win32'))
    set rtp+=~/vimfiles/vundle
else
    set rtp+=~/.vim/vundle
endif
call vundle#rc()

"github/vim-scripts
Bundle "taglist.vim"
" Bundle "project.vim"
" github
Bundle "Shougo/neocomplcache"

filetype plugin indent on
"***************************
" 動作
"***************************
" internal encoding
let &termencoding = &encoding
set fileencodings=utf-8,cp932,euc-jp
set encoding=utf-8
" enable mode line (e.g. // vim: set expandtab ff=unix : )
set modeline

"***************************
" 編集関連
"***************************
"行の右端で折り返しをしない
"set nowrap
"新しい行のインデントを現在行と同じにする
set autoindent
"クリップボードをWindowsと連携
set clipboard=unnamed
"Vi互換をオフ
"set nocompatible
"スワップファイル用のディレクトリ(スペースは使えないよぉ)
if (has('win32'))
    set directory=$HOME/vimfiles/swap
else
    set directory=$HOME/.vim/swap
endif
set nobackup
"インクリメンタルサーチを行う
set incsearch
"listで表示される文字のフォーマットを指定する
set list
set listchars=tab:>-,extends:$
"行番号を表示する
set number
"シフト移動幅
set shiftwidth=4
"閉じ括弧が入力されたとき、対応する括弧を表示する
set showmatch
"検索時に大文字を含んでいたら大/小を区別
set smartcase
"新しい行を作ったときに高度な自動インデントを行う
set smartindent
"行頭の余白内で Tab を打ち込むと、'shiftwidth' の数だけインデントする。
set smarttab
" tab を スペースで代用
set expandtab
"ファイル内の <Tab> が対応する空白の数
set tabstop=4
"カーソルを行頭、行末で止まらないようにする
set whichwrap=b,s,h,l,<,>,[,]
"検索をファイルの先頭へループしない
set nowrapscan
"賢いステータスライン
set laststatus=2
set statusline=%<%f\ %m\ %r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=\ (%v,%l)/%L%8P\ 
"全角スペースを視覚化
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=#666666
au BufNewFile,BufRead * match ZenkakuSpace /　/
"ディレクトリ閲覧時の表示をツリー形式に
let g:netrw_liststyle=3
" php の折りたたみ
let php_folding=1
au Syntax php set fdm=syntax

" 開いてるファイルと同じディレクトリをカレントディレクトリに
au   BufEnter *   execute ":lcd " . expand("%:p:h")

"***************************
" plugin settings
"***************************
" --------------------------------------
" neocomplecache.vim
" --------------------------------------
"起動時に有効化
let g:neocomplecache_enable_at_startup = 1
"大文字小文字の区別を無視
let g:neocomplecache_enable_smart_case = 1
"アンダーバーをうまい具合に
let g:neocomplecache_enable_underbar_completion = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3

" Enable include completion.

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
