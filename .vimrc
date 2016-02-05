" v . -N -u ~/dotbraddenver/.vimrc
" :so% to reload while editing

set rtp+=~/dotbraddenver/.vim/
" Store swapfiles and backup files in .vim/tmp
set dir=~/dotbraddenver/.vim/tmp
set backupdir=~/dotbraddenver/.vim/tmp

"http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
let mapleader = "\<Space>"
nnoremap <Leader>w :w<CR>

call plug#begin('~/dotbraddenver/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'altercation/vim-colors-solarized'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'rking/ag.vim'
" Plug 'tpope/vim-sensible'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'scrooloose/syntastic'
Plug 'pmsorhaindo/syntastic-local-eslint.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
call plug#end()

syntax enable
set background=dark
" set background=light
colorscheme solarized
let g:solarized_contrast="high"
let g:solarized_termcolors=16
" prevent hangs on long lines
set synmaxcol=250

" set mouse=a

" Gutter
set number

" Search
set hlsearch
set incsearch
set wildmenu
set wildignore+=javascripts-built,bower_components,test-result

" Whitespace
set autoindent
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set backspace=indent,eol,start
set shiftround

" Screen
" when to show status-line
set laststatus=2
set showcmd
set showmode

let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
" let g:airline_theme='base16'
let g:airline#extensions#tabline#show_buffers = 1

let NERDTreeMinimalUI=1
let NERDTreeMouseMode=2
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.svn$']


map <leader>t :FZF<CR>
nmap <leader>d :NERDTreeToggle<CR>
map <leader>D :NERDTreeFocus<CR>
" silver searcher
nnoremap <leader>a :Ag!<space>

function! s:buflist()
	redir => ls
	silent ls
	redir END
	return split(ls, '\n')
endfunction

function! s:bufopen(e)
	execute 'buffer' matchstr(a:e, '^[ 0-9]*')
endfunction

nnoremap <silent> <Leader><Enter> :call fzf#run({
	\   'source':  reverse(<sid>buflist()),
	\   'sink':    function('<sid>bufopen'),
	\   'options': '+m',
	\   'down':    len(<sid>buflist()) + 2
	\ })<CR>

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']
" /syntastic

" Override eslint with local version where necessary.
"let local_eslint = finddir('node_modules', '.;') . '/.bin/eslint'
"if matchstr(local_eslint, "^\/\\w") == ''
 " let local_eslint = getcwd() . "/" . local_eslint
"endif
"if executable(local_eslint)
"  let g:syntastic_javascript_eslint_exec = local_eslint
"endif

"let g:syntastic_javascript_eslint_exec = "/home/vagrant/.nvm/versions/node/v4.2.3/bin/eslint"

function! s:lintbits(line)
  let parts = split(a:line, ':')
  execute 'e ' parts[0]
endfunction
command! -bar Getlint call fzf#run({
      \ 'source': "eslint dynamic -f unix",
      \ 'sink': function('s:lintbits')
      \ })
command! Lint Getlint|SyntasticCheck|lfirst
map <leader>l :Lint<CR>
