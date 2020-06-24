"          __
"  __  __ /\_\    ___ ___   _ __   ___
" /\ \/\ \\/\ \ /' __` __`\/\`'__\/'___\
" \ \ \_/ |\ \ \/\ \/\ \/\ \ \ \//\ \__/
"  \ \___/  \ \_\ \_\ \_\ \_\ \_\\ \____\
"   \/__/    \/_/\/_/\/_/\/_/\/_/ \/____/

" vimrcでマルチバイト文字を使用しているため設定 {{{
scriptencoding utf-8
" }}}

" dein.vim settings {{{
" install dir {{{
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
" }}}

" dein installation check {{{
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . s:dein_repo_dir
endif
" }}}

" begin settings {{{
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " .toml file
  let s:rc_dir = expand('~/.vim')
  if !isdirectory(s:rc_dir)
    call mkdir(s:rc_dir, 'p')
  endif
  let s:toml = s:rc_dir . '/dein.toml'

  " read toml and cache
  call dein#load_toml(s:toml, {'lazy': 0})

  " end settings
  call dein#end()
  call dein#save_state()
endif
" }}}

" plugin installation check {{{
if dein#check_install()
  call dein#install()
endif
" }}}

" plugin remove check {{{
let s:removed_plugins = dein#check_clean()
if len(s:removed_plugins) > 0
  call map(s:removed_plugins, "delete(v:val, 'rf')")
  call dein#recache_runtimepath()
endif
" }}}

" }}}

" general settings {{{
" ミュート {{{
set belloff=all
" }}}

" 文字コード {{{
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis
set fileformats=unix,dos,mac
" }}}

" Leaderキーをスペースに設定 {{{
let g:mapleader = "\<Space>"
" }}}

" シンタックスを有効にする {{{
syntax enable
" }}}

" カラースキームを使う {{{
set background=dark
colorscheme solarized 
" }}}

" ファイル形式別プラグインとインデントを有効にする {{{
filetype plugin indent on
" }}}

" バックスペースとCtrl+hで削除を有効にする {{{
set backspace=2
" }}}
 
" 改行時自動インデント {{{
set smartindent
set autoindent
" }}}

" 自動インデントの空白の数
"set shiftwidth=2
" }}}

" 行番号を表示 {{{
"set number
" }}}

" タブでも常に空白を挿入 {{{
"set tabstop=4
"set expandtab
" }}}

" インクリメントサーチを有効にする {{{
set incsearch
" }}}

" 検索時大文字小文字を区別しない {{{
set ignorecase
" }}}

" 検索時に大文字を入力した場合ignorecaseが無効になる {{{
set smartcase
" }}}

" ハイライトサーチを有効にする {{{
set hlsearch
" }}}

" undoできる最大数 {{{
set undolevels=1000
" }}}

" クリップボードを共有 {{{
if has("mac")
  set clipboard+=unnamed
else
  set clipboard^=unnamedplus
endif
" }}}

" カーソルが常に中央に来るようにする {{{
set scrolloff=100
" }}}

" マクロで効果発揮 {{{
set lazyredraw
set ttyfast
" }}}

" 一行が長いファイルをsyntaxを制御することで軽くする {{{
set synmaxcol=256
" }}}

" カーソルラインを表示する {{{
set cursorline
" 描画負担軽減のため、行番号のみハイライト
if !has('nvim')
  set cursorlineopt=number
endif
" }}}

" netrwツリー表示を有効にする {{{
let g:netrw_liststyle=3
let g:netrw_banner=0
let g:netrw_sizestyle='H'
let g:netrw_timefmt='%Y/%m/%d(%a) %H:%M:%S'
" }}}

" fern
nnoremap <silent> <Leader>f :Fern . -drawer<CR>
augroup fern-setteings
  autocmd! *
  autocmd FileType fern nnoremap <silent> q ::bw!<CR>
augroup END

let g:fern#renderer = "devicons"

" vim-go settings {{{
nnoremap <silent><leader>r :QuickRun<CR>
" ファイル保存時go importを実行する
let g:go_fmt_command = 'goimports'

" goplsを有効化
let g:go_gopls_enabled = 1

" ファイル保存時、linterを実行する
"let g:go_metalinter_autosave = 1

" linter実行時、go vetのみを実行する
"let g:go_metalinter_autosave_enabled = ['vet']

" golangci-lintを使う
"let g:go_metalinter_command = "golangci-lint"

" vim-lspを使用するので、vim-goの`Ctrl+]`を無効にする
let g:go_def_mapping_enabled = 0

" GoDocでポップアップウィンドウを使用する
"let g:go_doc_popup_window = 1

" GoRunやGoTest時の画面分割方法変更
let g:go_term_mode = 'split'

" テンプレート作成を無効化
let g:go_template_autocreate = 0

" すでに開いているバッファに定義ジャンプする
let g:go_def_reuse_buffer = 1

" {{{ gofmtmd
let g:gofmtmd_auto_fmt = 0
" }}}

"let g:go_fold_enable = ['block', 'import', 'varconst', 'package_comment']

" key mapping
"augroup goMapping
"    autocmd!
"    au FileType go set foldmethod=syntax
"augroup END
autocmd FileType go nmap <leader>b  <Plug>(go-build)
"autocmd FileType go nmap <leader>r  <Plug>(go-run)
au FileType go nmap <leader>s <Plug>(go-def-split)
au FileType go nmap <leader>v <Plug>(go-def-vertical)
" }}}

" fzf settings {{{
" ファイル一覧を出すときにプレビュー表示
command! -bang -nargs=? -complete=dir Files
      \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

nnoremap <C-P> :Files<CR>
" }}}

" {{{ lexima
let g:lexima_enable_basic_rules = 1
" }}}

" 拡張子ごとのインデント設定 {{{
augroup fileTypeIndent
  autocmd!
  au FileType go setlocal tabstop=4
  au FileType vim setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  au FileType php setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  au FileType html setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  au FileType css setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  au FileType scss setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  au FileType javascript setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  au FileType typescript setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  au FileType vue  setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  au FileType yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  au FileType json setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  au FileType sh setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  au FileType fish setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
augroup END
" }}}

" wildmenuを有効にする {{{
set wildmenu
" }}}

" grepした結果をquickfixに表示する {{{
augroup grepwindow
  au!
  au QuickFixCmdPost *grep* cwindow
augroup END
" }}}

" quickfix widowの移動{{{
" 前へ
nnoremap [q :cprevious<CR>
" 次へ
nnoremap ]q :cnext<CR>
" 最初へ
nnoremap [Q :<C-u>cfirst<CR>
" 最後へ
nnoremap ]Q :<C-u>clast<CR>
" }}}

" カーソルラインの位置を保存する {{{
augroup cursorlineRestore
  autocmd!
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal! g'\"" |
        \ endif
augroup END
" }}}

" undoの保存先 {{{
if has('persistent_undo')
  let undo_path = expand('~/.vim/undo')
  " ディレクトリが存在しない場合は作成
  if !isdirectory(undo_path)
    call mkdir(undo_path, 'p')
  endif
  exe 'set undodir=' .. undo_path
  set undofile
endif
" }}}

" 矩形選択時に文字の無いところまで選択範囲を広げる {{{
set virtualedit=block
" }}}

" ヘルプの言語を日本語優先にする {{{
set helplang=ja
" }}}

" {{{ 他のバッファに移動する時に自動保存
set autowrite
" }}}

" ファイル保存時に整形する {{{
let s:format_targets = {
      \ 'javascript': '--use-tabs=false --single-quote=true %',
      \ 'html': '--use-tabs=false --single-quote=true %',
      \ 'css': '',
      \ 'json': '--tab',
      \ 'vue':  '--use-tabs=false --single-quote=true %',
      \ 'vim': '',
      \ 'java': '',
      \ }

" format function
function! Format() abort
  " if format target is not exsist, nothing to do
  if !has_key(s:format_targets, &ft)
    return
  endif

  let args = s:format_targets[&ft]
  let pos = getcurpos()

  " use js-beautify to format js, html, css
  if &ft is# 'javascript' || &ft is# 'html' || &ft is# 'vue'
    if executable('prettier')
      exe '%!prettier ' .. args
    else
      call s:echo_err("prettier doesn't installed, please refference the https://github.com/beautify-web/js-beautify")
    endif
  elseif &ft is# 'css'
    " TODO
  elseif &ft is# 'json'
    if executable('jq')
      exe "%!jq " .. args
    else
      call s:echo_err("jq doesn't installed, please refference the https://stedolan.github.io/jq/")
    endif
  else
    execute 'normal 1G=G'
  endif

  call setpos('.', pos)
endfunction

nnoremap <C-f> :call Format()<CR>
" }}}

" プラグインディレクトリ配下の.vimをすべてsourceする {{{
function! SourceDir(...) abort
  let l:path = getcwd()
  if a:0 > 1
    let l:path = a:1
  endif

  if !isdirectory(l:path)
    return
  endif

  exe 'set rtp^=' . l:path
  if isdirectory(l:path . '/plugin')
    exe 'runtime plugin/*.vim'
  endif

  if isdirectory(l:path . '/autoload')
    exe 'runtime autoload/*.vim'
  endif

  if isdirectory(l:path . '/syntax')
    exe 'runtime syntax/*.vim'
  endif
endfunction

command! -nargs=* Source call SourceDir(<f-args>)
" }}}

" listの設定 {{{
set list
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%
" }}}

" {{{ 行末のホワイトスペース削除
let s:spaces_target_ft = {
      \ 'markdown': 0,
      \ 'go': 1,
      \ 'javascript': 1,
      \ 'graphql': 1,
      \ 'terminal': 1,
      \ }
augroup HighlightTrailingSpaces
  autocmd!
  autocmd BufWritePre * if get(s:spaces_target_ft, &ft, 0) | :silent keeppatterns %s/\s\+$//ge | endif
  autocmd VimEnter,WinEnter,ColorScheme * highlight TrailingSpaces term=underline guibg=Red ctermbg=Red
  autocmd VimEnter,WinEnter * if get(s:spaces_target_ft, &ft, 0) | match TrailingSpaces /\s\+$/ | endif
augroup END
" }}}

" swapファイルを作成しない
set noswapfile

" {{{ セッションで保存する対象を設定する
if !has('nvim')
  set sessionoptions=blank,buffers,curdir,folds,help,tabpages,winsize,terminal
endif
" }}}

" ウィンドウサイズ自動調整を無効化
"set noequalalways

" タブを常に表示
set showtabline=2

" 数値の加減算を考慮
if has('patch-8.2.0860')
  setglobal nrformats+=unsigned
endif

" {{{ 外部でファイルの変更があった場合、自動的に読み直す
set autoread
augroup vimrc-misc
  au!
  autocmd WinEnter,FocusGained * checktime
augroup END
" }}}

" {{{検索æに最後まで行ったら最初に戻る
set wrapscan
" }}}

" }}}

" gina
nnoremap <silent> gs :Gina status<CR>
nnoremap <silent> gl :Gina log<CR>
call gina#custom#mapping#nmap(
      \ 'status', 'gp',
      \ ':<C-u>Gina push<CR>',
      \ {'noremap': 1, 'silent': 1},
      \)
call gina#custom#mapping#nmap(
      \ 'status', 'cm',
      \ ':<C-u>Gina commit<CR>',
      \ {'noremap': 1, 'silent': 1},
      \)
call gina#custom#mapping#nmap(
      \ 'status', 'ca',
      \ ':<C-u>Gina commit --amend<CR>',
      \ {'noremap': 1, 'silent': 1},
      \)
call gina#custom#mapping#nmap(
      \ 'status', 'dp',
      \ '<Plug>(gina-patch-oneside-tab)',
      \ {'silent': 1},
      \)
call gina#custom#mapping#nmap(
      \ 'status', 'q',
      \ ':<C-u>bw!<CR>',
      \ {'noremap': 1, 'silent': 1},
      \)
call gina#custom#mapping#nmap(
      \ 'status', 'ga',
      \ '--',
      \ {'silent': 1},
      \)
call gina#custom#mapping#vmap(
      \ 'status', 'ga',
      \ '--',
      \ {'silent': 1},
      \)
call gina#custom#mapping#nmap(
      \ 'log', 'q',
      \ ':<C-u>bw!<CR>',
      \ {'noremap': 1, 'silent': 1},
      \)
call gina#custom#mapping#nmap(
      \ 'log', 'dd',
      \ '<Plug>(gina-changes-of)',
      \ {'silent': 1},
      \)
call gina#custom#mapping#nmap(
      \ 'changes', 'q',
      \ ':<C-u>bw!<CR>',
      \ {'noremap': 1, 'silent': 1},
      \)


" key mappings {{{

"ノーマルモードからjjで離脱
inoremap <silent> jj <ESC>
"っj からうまく離脱する処理達 {{{
inoremap <silent> っj <C-o>:call <SID>disableIme()<CR><ESC>
function! s:disableIme()
    if has('mac')
        call job_start(['osascript', '-e', 'tell application "System Events" to key code {102}'],
                    \ {'in_io': 'null', 'out_io': 'null', 'err_io': 'null'})
    endif
endfunction
" }}}

" <Leader>というプレフィックスキーにスペースを使用する
let g:mapleader = "\<Space>"

" *でカーソルを移動しないようにする
noremap * *N

" ファイル保存と終了 {{{
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q!<CR>
" }}}

" 検索
nnoremap <C-G><C-G> :Ggrep <C-R><C-W><CR><CR>

" カーソル下の単語を、置換後の文字列の入力を待つ状態にする
nnoremap <Leader>re :%s;\<<C-R><C-W>\>;gc<Left><Left>;

" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>

" vimrcを開く
nnoremap <Leader>. :new ~/.vimrc<CR>
nnoremap <Leader>s :source ~/.vimrc<CR>

" 行先頭と行末
noremap H ^
noremap L g_

" タブ切り替え
nnoremap <C-l> gt
nnoremap <C-h> gT

" numberとrelativenumberの切り替え
nnoremap <silent> <Leader>n :set relativenumber!<CR>

" 改行
nnoremap <C-j> o<ESC>
nnoremap <C-k> O<ESC>
nnoremap o A<CR>

" 挿入モードでのカーソル移動
inoremap <silent> <C-f> <Right>
inoremap <silent> <C-b> <Left>
inoremap <silent> <C-e> <Esc>A
inoremap <silent> <C-a> <Esc>I

" 囲う
nnoremap <silent> gw[ cw``<Esc>P
vnoremap <silent> gw[ c``<Esc>P

" 全選択
nnoremap <Leader>a ggVG

" ビジュアル選択VVV {{{
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)
" }}}

" Split window
nmap ss :split<Return><C-w>w
nmap sv :vsplit<Return><C-w>w

" Move window
map sh <C-w>h
map sk <C-w>k
map sj <C-w>j
map sl <C-w>l

" }}}

" emmet {{{
let g:user_emmet_install_global = 0
let g:user_emmet_settings = {
      \   'variables': {
      \     'lang' : 'ja'
      \   }
      \ }
let g:user_emmet_leader_key = '<C-g>'

augroup emmet
  autocmd!
  au FileType vue,html,javascript,css,scss,php EmmetInstall
  au FileType vue,html,css,scss,php imap <buffer> <C-f> <plug>(emmet-expand-abbr)
augroup END
" }}}

" {{{ vista
let g:vista_default_executive = 'vim_lsp'
" }}}
