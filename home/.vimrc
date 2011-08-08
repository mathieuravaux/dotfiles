set bs=2
set nocompatible
set noerrorbells
set visualbell
filetype plugin indent on
set showmatch
set autoindent
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4

set wrapmargin=8
set ruler
set mouse=a
set clipboard=unnamed

set showmode

set laststatus=2

" Active la coloration syntaxique quand c'est possible
if &t_Co > 2 || has("gui_running")
        syntax on
endif

if has("gui_running")
    " Le focus suit la souris
    set mousef
    " Le bouton droit affiche une popup
    set mousemodel=popup_setpos
endif
