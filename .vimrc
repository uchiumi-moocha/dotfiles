" vimrc 2021/01 manjaro-Linux

" 基本設定 :::::::::::::::::::::::::::::::::::::::::::::
" 文字コード
set fileencodings=utf-8,cp932
" ファイルを上書きする前にバックアップを作ることを無効化
set nowritebackup
" ファイルを上書きする前にバックアップを作ることを無効化
set nobackup
" vim の矩形選択で文字が無くても右へ進める
set virtualedit=block
" 挿入モードでバックスペースで削除できるようにする
set backspace=indent,eol,start
" 全角文字専用の設定
set ambiwidth=double
" wildmenuオプションを有効(vimバーからファイルを選択できる)
set wildmenu
" スワップファイルを作成しない
set noswapfile
" ヤンクでクリップボードにコピー
set clipboard=unnamedplus
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
set cursorline
" シンタックスハイライト
syntax on

" 操作設定 ------------------------------------------
" マウス有効化
" set mouse=a
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
  let s:input_status = system("fcitx-remote")
  if s:input_status == 2
    let g:input_toggle = 1
    let l:a = system("fcitx-remote -c")
  endif
endfunction

set ttimeoutlen=150
"Leave Insert mode
autocmd InsertLeave * call Fcitx2en()
" auto fcitx - - - - - - - - - - - - - - - -

" vim-plug ::::::::::::::::::::::::::::::::::::
call plug#begin()

Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'vim-airline/vim-airline'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mattn/ctrlp-register'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/vim-easy-align'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'tpope/vim-surround'
Plug 'raimondi/delimitmate'
Plug 'plasticboy/vim-markdown', { 'for': 'md' }
Plug 'simeji/winresizer'
Plug 'deton/jasegment.vim'
Plug 'mhinz/vim-startify'

Plug 'qpkorr/vim-renamer', { 'on': 'Renamer' }
Plug 'itchyny/calendar.vim'
Plug 'reireias/vim-cheatsheet'

Plug 'vim-jp/vimdoc-ja'

" colorscheme
Plug 'nanotech/jellybeans.vim'
Plug 'arzg/vim-colors-xcode'
Plug 'cormacrelf/vim-colors-github'
Plug 'reedes/vim-colors-pencil'
Plug 'ayu-theme/ayu-vim' " or other package manager


call plug#end()

" pluginの設定 --------------------------------

set helplang=ja,en


" NERDTree Ctrl+n で起動する
nnoremap <silent> <C-n> :NERDTreeToggle<CR>
let NERDTreeShowBookmarks=1
let NERDTreeShowHidden = 1

" airline Ctrl-mでバッファの移動
nmap <Leader>m <Plug>AirlineSelectPrevTab
let g:airline#extensions#tabline#enabled = 1

" CtrlP
let g:ctrlp_extensions = ['dir', 'register']
" キャッシュを使用して検索を高速化
let g:ctrlp_use_caching = 1
" vim終了時にキャッシュをクリアしない
let g:ctrlp_clear_cache_on_exit = 0
" 隠しファイルを表示しない
let g:ctrlp_show_hidden = 1
nnoremap <silent> <Leader>b :<C-u>CtrlPBuffer<CR>
nnoremap <silent> <Leader>r :<C-u>CtrlPRegister<CR>
nnoremap <silent> <Leader><Leader> :<C-u>CtrlPMRUFiles<CR>

"  Startify
let g:startify_bookmarks = [ '/home/uchiumi/Desktop/vimのネタ' ]
let g:startify_change_to_dir = 1
let g:startify_change_to_vcs_root = 1
let g:ascii = [
        \ '(・ω<) Chu,,, ♥ Vim ♥',
        \]
let g:startify_custom_header = g:ascii + startify#fortune#boxed()
let g:startify_enable_special = -1
let g:startify_lists = [
          \ { 'type': 'files',     'header': ['   MRU'] },
          \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
          \ { 'type': 'sessions',  'header': ['   Sessions'] },
          \ { 'type': 'bookmarks', 'header': ['   Bookmarks'] }
          \ ]
let g:startify_skiplist = [
        \ '^/tmp',
        \ '.swap$',
        \ '.tmp$',
        \ ]
let g:startify_update_oldfiles = 1

" For Misc options
let g:startify_commands = []
let g:startify_custom_footer = ['----------------------------------------- Startify --']
let g:startify_disable_at_vimenter = 0
let g:startify_enable_unsafe = 0
let g:startify_files_number = 5
let g:startify_fortune_use_unicode = 0
let g:startify_padding_left = 4
let g:startify_relative_path = 1
let g:startify_use_env = 1

" For Sessions     
let g:startify_session_autoload = 1     
let g:startify_session_before_save = ['echo "Saving this session ..."']    
let g:startify_session_delete_buffers = 0     
let g:startify_session_dir = '~/.vim/session'     
let g:startify_session_number = 20     
let g:startify_session_persistence = 1     
let g:startify_session_remove_lines = ['setlocal', 'winheight']    
let g:startify_session_savecmds = ['echo "Saved a session."']
let g:startify_session_savevars = [    
           \ 'g:startify_session_savevars',    
           \ 'g:startify_session_savecmds',    
           \ ]    
let g:startify_session_sort = 1

"FZF
" Terminal buffer options for fzf
autocmd! FileType fzf
autocmd  FileType fzf set noshowmode noruler nonu
nnoremap <silent> <Leader>zf  :Files<CR>
nnoremap <silent> <Leader>zc  :Colors<CR>
nnoremap <silent> <Leader>zb  :Buffers<CR>
nnoremap <silent> <Leader>zL  :Lines<CR>
nnoremap <silent> <Leader>zz  :History, Buffers<CR>

" Start interactive EasyAlign in visual mode
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" vim_markdown
" コードブロック(`)の表示
let g:vim_markdown_conceal_code_blocks = 0
" 折りたたみしない
let g:vim_markdown_folding_disabled = 1

" マークダウンプレビュー
nnoremap <silent> <Leader>mp :MarkdownPreview<CR>

" winresizer
let g:winresizer_vert_resize = 2
let g:winresizer_horiz_resize = 2

" Cheat_vim
let g:cheatsheet#cheat_file = '/home/uchiumi/Cheat_vim.md'
nnoremap <Leader>?  :Cheat<CR>

" カラースキーム
set background=light
set termguicolors  " TrueColor対応
" let ayucolor="light"  " for light version of theme
" let ayucolor="mirage" " for mirage version of theme
" let ayucolor="dark"   " for dark version of theme
colorscheme xcodelight



" pluginの設定-end ----------------------------

" <Leader> + xでRanger
function RangerExplorer()
    exec "silent !ranger --choosefile=/tmp/vim_ranger_current_file " . expand("%:p:h")
    if filereadable('/tmp/vim_ranger_current_file')
        exec 'edit ' . system('cat /tmp/vim_ranger_current_file')
        call system('rm /tmp/vim_ranger_current_file')
    endif
    redraw!
endfun
map <Leader>x :call RangerExplorer()<CR>

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

