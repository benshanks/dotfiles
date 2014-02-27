" enable pathogen package mgmt
execute pathogen#infect()
call pathogen#helptags()

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Color scheme
syntax enable
set background=light
colorscheme solarized

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands

set incsearch		" do incremental searching
set ignorecase " ignore case when searching
set smartcase	 " ignore case if search string is all lower case, case-sensitve otherwise
set hlsearch

set relativenumber     " use relative line numbers
set number             " except for the current line - absolute number there
set laststatus=2
set showcmd

set tabstop=2           " 2 spaces for a tab
set shiftwidth=2        " 2 spaces for autoindenting
set softtabstop=2       " when <BS>, pretend a tab is removed even if spaces
set expandtab           " expand tabs to spaces (overloadable by file type)

set foldenable           " enable code folding
set autoindent           " turns it on
set smartindent          " does the right thing (mostly) in programs
set autoread                      " automatically update file when editted outside of vim

set pastetoggle=<F2> " Paste mode to prevent autoindentation of pasted lines
set clipboard=unnamed   " yank and paste with the system clipboard

" Centralize backups, swapfiles and undo history (need directories obvs
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
     set undodir=~/.vim/undo
endif

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif
