call plug#begin()
" Plug 'altercation/vim-colors-solarized'
Plug 'andys8/vim-elm-syntax'
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh'}
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
Plug 'elm-tooling/elm-vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }
Plug 'leafgarland/typescript-vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'reasonml-editor/vim-reason-plus'
Plug 'rking/ag.vim'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-fugitive'
Plug 'iCyMind/NeoSolarized'
" Plug 'trevordmiller/nova-vim'
Plug 'w0rp/ale'
call plug#end()

" colorscheme nova
" colorscheme solarized
colorscheme NeoSolarized

set background=dark
set mouse=a
set number
set showcmd
set visualbell
set clipboard+=unnamedplus
set splitbelow
set splitright
set termguicolors

" Whitespace
set autoindent
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set backspace=indent,eol,start
set shiftround

"http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
let mapleader = "\<Space>"

noremap  <leader>8 :Ag! "<cword>"<CR>
nnoremap <leader>a :Ag!<space>
nnoremap <leader>b :Buffers<CR>
map      <leader>d :NERDTreeToggle<CR>
map      <leader>t :FZF<CR>
nnoremap <Leader>w :w<CR>

" http://vim.wikia.com/wiki/VimTip906
nnoremap <leader>pm :set invpaste paste?<CR>
set pastetoggle=<leader>pm
set showmode

" let g:ag_prg="ag --path-to-ignore ~/dotbraddenver/.ignore --vimgrep"
let g:ag_prg="rg --vimgrep"

let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='solarized'
let g:airline#extensions#tabline#show_buffers = 0

" let g:ale_completion_enabled = 1
let g:ale_completion_enabled = 0
" let g:ale_linters = { 'elm': ['elm_ls'] }
let g:airline#extensions#ale#enabled = 1

let g:deoplete#enable_at_startup = 1
" let g:deoplete#enable_at_startup = 0

let g:elm_setup_keybindings = 0
  
let g:elm_format_autosave = 1

let g:LanguageClient_rootMarkers = {
  \ 'elm': ['elm.json'],
  \ }
let g:LanguageClient_serverCommands = {
    \ 'reason': ['~/dotbraddenver/reason-language-server.exe'],
    \ 'ocaml': ['ocaml-language-server', '--stdio'],
    \ }
" \ 'reason': ['ocaml-language-server', '--stdio'],
" nnoremap <silent> gd :call LanguageClient_textDocument_definition()<cr>
nnoremap <silent> gf :call LanguageClient_textDocument_formatting()<cr>
nnoremap <silent> <cr> :call LanguageClient_textDocument_hover()<cr>

let NERDTreeMinimalUI=1
let NERDTreeMouseMode=2
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.svn$']

map \ :TComment<CR>
vmap \ :TComment<CR>gv

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Terminal
highlight TermCursor ctermfg=red guifg=red

tnoremap <Esc> <C-\><C-n>

:au BufEnter * if &buftype == 'terminal' | :startinsert | endif

let g:ale_fixers = {
\   'css': ['prettier'],
\   'elm': ['elm-format', 'trim_whitespace'],
\   'javascript': ['prettier'],
\   'javascriptreact': ['prettier'],
\   'yaml': ['prettier'],
\}


" fix files automatically on save.
" This is off by default.
let g:ale_fix_on_save = 1
let g:ale_lint_on_save = 1

" https://github.com/leojpod/dotfiles/blob/master/nvim-config/configs/tools/coc.vim
nmap <silent> gp <Plug>(coc-diagnostic-prev)
nmap <silent> gn <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <leader>ac  <Plug>(coc-codeaction)
nmap <leader>qf  <Plug>(coc-fix-current)<Paste>
