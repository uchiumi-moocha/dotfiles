

" 基本設定 :::::::::::::::::::::::::::::::::::::::::::::
" 文字コード
set fileencodings=utf-8,cp932
" ファイルを上書きする前にバックアップを作ることを無効化
set nowritebackup
" ファイルを上書きする前にバックアップを作ることを無効化
set nobackup
" 全角文字専用の設定
set ambiwidth=double
" wildmenuオプションを有効(vimバーからファイルを選択できる)
set wildmenu
" スワップファイルを作成しない
set noswapfile
" すべての数を10進数として扱う
set nrformats=
" 日本語ヘルプ優先
set helplang=ja

" 検索設定 -------------------------------------
" 検索するときに大文字小文字を区別しない
set ignorecase
" 小文字で検索すると大文字と小文字を無視して検索
set smartcase
" 検索がファイル末尾まで進んだら、ファイル先頭から再び検索
set wrapscan
" インクリメンタル検索
set incsearch
" 検索結果をハイライト表示
set hlsearch
" Escの2回押しでハイライト消去
nnoremap <Esc><Esc> :nohlsearch<CR><ESC>

" 表示設定 ----------------------------------
" 行番号を表示
set number
" タイトルを表示
set title
" メッセージ表示欄を2行確保
set cmdheight=2
" ステータス行を常に表示
set laststatus=2
" エラーメッセージの表示時にビープを鳴ない
set noerrorbells
" 対応する括弧やブレースを表示
set showmatch matchtime=1
" インデント方法の変更
set cinoptions+=:0
" ウィンドウの右下にまだ実行していない入力中のコマンドを表示
set showcmd
" 省略されずに表示
set display=lastline
" 不可視文字を表示
set list
" 行末のスペースを可視化
set listchars=tab:>_,trail:~
" インデント幅
set shiftwidth=2
" タブキー押下時に挿入される文字幅を指定
set softtabstop=2
" ファイル内にあるタブ文字の表示幅
set tabstop=2
" タブをスペースに変換する
" set expandtab
" 対応する括弧を強調表示
set showmatch
" 改行時に入力された行の末尾に合わせて次の行のインデントを増減する
set smartindent
" 検索にマッチした行以外を折りたたむ(フォールドする)機能
set nofoldenable
" カーソルライン
"  set cursorline
" set cursorcolumn
" シンタックスハイライト
syntax on
" truecolor
set termguicolors
" " カーソルの形状の設定
" if has('vim_starting')
"     " 挿入モード時に非点滅の縦棒タイプのカーソル
"     let &t_SI .= "\e[6 q"
"     " ノーマルモード時に非点滅のブロックタイプのカーソル
"     let &t_EI .= "\e[2 q"
"     " 置換モード時に非点滅の下線タイプのカーソル
"     let &t_SR .= "\e[4 q"
" endif
" カーソル位置の設定
set so=5

" 操作設定 ------------------------------------------
" マウス有効化
" set mouse=a
" vim の矩形選択で文字が無くても右へ進める
set virtualedit=block
" 挿入モードでバックスペースで削除できるようにする
set backspace=indent,eol,start
" ノーマルモード切り替えの遅延をなくす
set ttimeoutlen=50
" コマンドラインの履歴を10000件保存する
set history=10000
" yでコピーした時にクリップボードに入る
set guioptions+=a
" 折り返し表示の際にも表示行単位で移動する
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
" 分割画面移動
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l


" fcitx EcsでIME停止 - - - - - - - - - - - -
let g:input_toggle = 1
function! Fcitx2en()
  let s:input_status = system("fcitx5-remote")
  if s:input_status == 2
    let g:input_toggle = 1
    let l:a = system("fcitx5-remote -c")
  endif
endfunction

set ttimeoutlen=150
"Leave Insert mode
autocmd InsertLeave * call Fcitx2en()
" auto fcitx - - - - - - - - - - - - - - - -

" netrw 設定 ---------
" ファイルツリーの表示形式、1にするとls -laのような表示になります
let g:netrw_liststyle=1
" ヘッダを非表示にする
let g:netrw_banner=0
" サイズを(K,M,G)で表示する
let g:netrw_sizestyle="H"
" 日付フォーマットを yyyy/mm/dd(曜日) hh:mm:ss で表示する
let g:netrw_timefmt="%Y/%m/%d(%a) %H:%M:%S"
" プレビューウィンドウを垂直分割で表示する
let g:netrw_preview=1

packadd vim-jetpack
call jetpack#begin()
Jetpack 'tani/vim-jetpack', {'opt': 1} "bootstrap
Jetpack 'junegunn/fzf', { 'do': { -> fzf#install() } }
Jetpack 'junegunn/fzf.vim'
Jetpack 'mcchrish/nnn.vim'

call jetpack#end()



" 追加スクリプト ::::::::::::::::::::::::::::::
" SyntaxInfo < 色情報取得 >
function! s:get_syn_id(transparent)
  let synid = synID(line("."), col("."), 1)
  if a:transparent
    return synIDtrans(synid)
  else
    return synid
  endif
endfunction
function! s:get_syn_attr(synid)
  let name = synIDattr(a:synid, "name")
  let ctermfg = synIDattr(a:synid, "fg", "cterm")
  let ctermbg = synIDattr(a:synid, "bg", "cterm")
  let guifg = synIDattr(a:synid, "fg", "gui")
  let guibg = synIDattr(a:synid, "bg", "gui")
  return {
        \ "name": name,
        \ "ctermfg": ctermfg,
        \ "ctermbg": ctermbg,
        \ "guifg": guifg,
        \ "guibg": guibg}
endfunction
function! s:get_syn_info()
  let baseSyn = s:get_syn_attr(s:get_syn_id(0))
  echo "name: " . baseSyn.name .
        \ " ctermfg: " . baseSyn.ctermfg .
        \ " ctermbg: " . baseSyn.ctermbg .
        \ " guifg: " . baseSyn.guifg .
        \ " guibg: " . baseSyn.guibg
  let linkedSyn = s:get_syn_attr(s:get_syn_id(1))
  echo "link to"
  echo "name: " . linkedSyn.name .
        \ " ctermfg: " . linkedSyn.ctermfg .
        \ " ctermbg: " . linkedSyn.ctermbg .
        \ " guifg: " . linkedSyn.guifg .
        \ " guibg: " . linkedSyn.guibg
endfunction
command! SyntaxInfo call s:get_syn_info()
" SyntaxInfo end - - - - - -

