let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"set mouse=a
set encoding=utf-8
set nocompatible
syntax on
syntax enable
"set number
"set relativenumber
set ruler
set autoread
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab
set autoindent
set hlsearch
filetype plugin on
filetype indent on
set laststatus=2
syn on
let g:dracula_colorterm = 0

function! CurDir()
    let curdir = substitute(getcwd(), "~/", "g")
    return curdir
endfunction

function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    else
        return ''
    endif
endfunction

" disable Ex mode
nmap Q <Nop>

"set noai
"set et

" When editing a file, always jump to the last known cursor position.
if has("autocmd")
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
\| exe "normal g'\"" | endif
endif


" correction
autocmd FileType tex setlocal spell spelllang=fr

" toogle between paste / nopaste
set pastetoggle=<F2>

" move tab easily
"nnoremap <C-Left> :tabprevious<CR>
"nnoremap <C-Right> :tabnext<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

" vim-plug
call plug#begin('~/.vim/plugged')

Plug 'pearofducks/ansible-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'bronson/vim-trailing-whitespace'
Plug 'jiangmiao/auto-pairs'
"Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
"Plug 'junegunn/fzf.vim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'https://github.com/preservim/nerdtree' " NerdTree
Plug 'https://github.com/tpope/vim-commentary' " For Commenting gcc & gc
Plug 'https://github.com/ryanoasis/vim-devicons' " Developer Icons
Plug 'https://github.com/rafi/awesome-vim-colorschemes' " Retro Scheme

call plug#end()
" end vim-plug
"autocmd BufRead,BufNewFile ~/depot/* set syntax=ansible
let g:ansible_attribute_highlight = "ob"

let vim_markdown_preview_pandoc=1
let vim_markdown_preview_browser='firefox'
let vim_markdown_preview_use_xdg_open=1

nnoremap <C-e> :NERDTreeFocus<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
" Window Navigation with Ctrl-[hjkl]
noremap <C-J> <C-W>j
noremap <C-K> <C-W>k
noremap <C-H> <C-W>h
noremap <C-L> <C-W>l
let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Appearance
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif


"set t_Co=256
syntax enable
set background=dark
colorscheme onedark


" cursor highlight
set cursorline
"hi CursorLine term=bold cterm=bold guibg=Grey40
set cursorcolumn
"hi Cursorcolumn guibg=Grey40
" vim airline
let g:airline_powerline_fonts = 1
"let g:airline_theme='murmur'
let g:airline_theme='onedark'
let g:airline#extensions#tabline#enabled = 1
map <C-L> <C-W>l
map <C-H> <C-W>h
let g:coc_disable_startup_warning = 1
nnoremap <C-p> :Files<Cr>

