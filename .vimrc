syntax enable

set hidden
set wildmenu
set showmode
set showcmd

set ignorecase
set smartcase

set backspace=indent,eol,start

set autoindent

set ruler
set laststatus=2

set confirm

set cmdheight=2

set number relativenumber

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

set cursorline

set shiftwidth=4
set softtabstop=4
set expandtab

set list
set listchars=tab:>\ ,nbsp:�,trail:_,eol:�

set background=dark
colorscheme solarized
