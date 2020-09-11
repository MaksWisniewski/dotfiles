syntax on
set timeoutlen=10

filetype off                  
set autoindent
set background=dark
set cmdheight=2
set hidden
set hlsearch
set incsearch
set laststatus=2
set nobackup
set nocompatible
set nostartofline
set nowritebackup
set number
set scrolloff=4
set visualbell
set tabstop=4
set shiftwidth=4
set bs=2

"alt + hjkl
imap h <Left>
imap j <Down>
imap k <Up>
imap l <Right>
imap ; <Right><Left>

imap H <Left>
imap J <Down>
imap K <Up>
imap L <Right>

call plug#begin('~/.vim/plugged')

Plug 'itchyny/lightline.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'morhetz/gruvbox'
Plug 'maxboisvert/vim-simple-complete'

call plug#end()


colorscheme gruvbox
nnoremap <Space>t :bot term ++rows=12<CR>
