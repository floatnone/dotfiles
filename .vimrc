" .vimrc

" !silent is used to suppress error messages if the config line
" references plugins/colorschemes that might be missing

" Disable Vi compatibility
set nocompatible

" Point to location of pathogen submodule (since it's not in .vim/autoload)
silent! runtime bundle/vim-pathogen/autoload/pathogen.vim
" Call pathogen plugin management
silent! call pathogen#infect()

if has("autocmd")
    " Load files for specific filetypes
    filetype on
    filetype indent on
    filetype plugin on

    " Languages with specific tabs/space requirements
    autocmd FileType make setlocal ts=4 sts=4 sw=4 noexpandtab
    " Automatically strip trailing whitespace on file save
    autocmd BufWritePre *.css,*.html,*.js,*.json,*.md,*.php,*.py,*.rb,*.scss,*.sh,*.txt :call StripTrailingWhitespace()
    " Don't treat json as javascript
    autocmd BufRead,BufNewFile *.json set filetype=json
endif

if has("syntax")
    " Enable syntax highlighting
    syntax enable
    " Set 256 color terminal support
    set t_Co=256
    " Set dark background
    set background=dark
    " Set colorscheme
    silent! colorscheme solarized
endif

if has("cmdline_info")
    " Show the cursor line and column number
    set ruler
    " Show partial commands in status line
    set showcmd
    " Show whether in insert or replace mode
    set showmode
endif

if has('statusline')
    " Always show status line
    set laststatus=2
    " Broken down into easily includeable segments
    " Filename
    set statusline=%<%f\
    " Options
    set statusline+=%w%h%m%r
    " Current dir
    set statusline+=\ [%{getcwd()}]
    " Right aligned file nav info
    set statusline+=%=%-14.(%l,%c%V%)\ %p%%
endif

if has("wildmenu")
    " Show a list of possible completions
    set wildmenu
    " Tab autocomplete longest possible part of a string, then list
    set wildmode=longest,list
    if has ("wildignore")
        set wildignore+=*.a,*.pyc,*.o,*.orig
        set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png
        set wildignore+=.DS_Store,.git,.hg,.svn
        set wildignore+=*~,*.sw?,*.tmp
    endif
endif

if has("extra_search")
    " Highlight searches [use :noh to clear]
    set hlsearch
    " Highlight dynamically as pattern is typed
    set incsearch
    " Ignore case of searches...
    set ignorecase
    " ...unless has mixed case
    set smartcase
endif

" Show hidden files when using ctrlp
let g:ctrlp_show_hidden = 1

" Change mapleader
let mapleader=","

" Backspace through everything in INSERT mode
set backspace=indent,eol,start
" Optimize for fast terminal connections
set ttyfast
" Use UTF-8 without BOM
set encoding=utf-8 nobomb

" No line wrapping
set nowrap
" Use 2 spaces for indentation
set shiftwidth=2
" Use 2 spaces for soft tab
set softtabstop=2
" Use 2 spaces for tab
set tabstop=2
" Expand tab to spaces
set expandtab
" Enable line numbers
set number
" Highlight current line
set cursorline
" Start scrolling three lines before the horizontal window border
set scrolloff=3
" Don’t reset cursor to start of line when moving around.
set nostartofline

" Show 'invisible' characters
set list
" Set characters used to indicate 'invisible' characters
set listchars=tab:▸\
set listchars+=trail:·
set listchars+=nbsp:_
"set listchars+=eol:¬

" Centralize backups, swapfiles and undo history
set backupdir=$HOME/.vim/backups
set directory=$HOME/.vim/swaps
if exists("&undodir")
    set undodir=$HOME/.vim/undo
endif
set viminfo+=n$HOME/.vim/.viminfo

" Strip trailing whitespace (,$)
noremap <leader>$ :call StripTrailingWhitespace()<CR>

" Faster viewport scrolling (3 lines at a time)
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>
vnoremap <C-e> 3<C-e>
vnoremap <C-y> 3<C-y>

" Make `Y` work from the cursor to the end of line (which is more logical)
nnoremap Y y$

" Load local machine settings if they exist
if filereadable(glob("$HOME/.vimrc.local"))
    source $HOME/.vimrc.local
endif
