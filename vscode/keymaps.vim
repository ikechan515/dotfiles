"====================================================================================================
" キーマッピング設定
"==============================================
"ノーマルモードからjjで離脱
inoremap <silent> jj <ESC>

"保存
nnoremap <Leader>w :w<CR>
"閉じる
nnoremap <Leader>q :q!<CR>

" *でカーソルを移動しないようにする
noremap * *N

" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>

" 行先頭と行末
noremap H ^
noremap L g_

" タブ切り替え
nnoremap <C-l> gt
nnoremap <C-h> gT

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
nnoremap <silent> gw[ cw''<Esc>P
vnoremap <silent> gw[ c''<Esc>P

" 画面横分割
nmap ss <C-w>s
" 画面縦分割
nmap sv <C-w>v

" ペイン移動
map sh <C-w>h
map sk <C-w>k
map sj <C-w>j
map sl <C-w>l

"easymotion
nnoremap <Leader>j <Leader><Leader>s

" 全選択
nnoremap <Leader>a ggVG

"連続ペースト
vnoremap p "_dP
