" OPTIONS
set nocompatible		" be iMproved, required
filetype off			" required

set exrc
set guicursor=
set relativenumber
set nu
set nohlsearch
set hidden
set noerrorbells
set nowrap
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set scrolloff=8
set colorcolumn=80
set signcolumn=yes
set history=20
" " Set completeopt to have a better completion experience
" set completeopt=menuone,noinsert,noselect
" " Avoid showing message extra message when using completion
" set shortmess+=c


call plug#begin('~/.config/nvim/plugged')

Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'


" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

" Snippets
" Plug 'hrsh7th/vim-vsnip'
" Plug 'hrsh7th/vim-vsnip-integ'
" Plug 'rafamadriz/friendly-snippets'

" Emmet-vim HTML autocomplete
" Plug 'mattn/emmet-vim'

" gruvbox theme
Plug 'morhetz/gruvbox'

" Twig
" Plug 'lumiliet/vim-twig'

" Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'


" Undotree
" Plug 'mbbill/undotree'

" Treesitter
" Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}


" " fzf
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'junegunn/fzf.vim'


" Initialize plugin system
call plug#end()


colorscheme gruvbox

let mapleader = " "
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <silent> <leader>bn <cmd>:bn<cr>




" Move lines
" Normal mode
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==

" Toggle numbers
nnoremap <C-N> :set invrelativenumber invnumber<CR>

" " Insert mode
" inoremap <C-j> <ESC>:m .+1<CR>==gi
" inoremap <C-k> <ESC>:m .-2<CR>==gi

" " Visual mode
" vnoremap <C-j> :m '>+1<CR>gv=gv
" vnoremap <C-k> :m '<-2<CR>gv=gv

command! -range ListToKeyPairs 
      \ execute '<line1>,<line2>s/\(.*\)\t\(.*\)/"\1": "\2",'












syntax enable
filetype plugin indent on		"required


lua require('init')


" INDENTS
" autocmd Filetype javascript setlocal ts=4 sw=4 sts=4 expandtab
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
autocmd Filetype html setlocal ts=2 sw=2 sts=2
autocmd Filetype *.twig setlocal ts=2 sw=2 sts=2
autocmd Filetype php setlocal ts=4 sw=4 sts=4 expandtab
autocmd BufRead,BufNewFile *.css setlocal tabstop=2 shiftwidth=2 softtabstop=2



" Autoinstall missing plugins on startup
" autocmd VimEnter *
"   \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
"   \|   PlugInstall --sync | q
"   \| endif


"""SNIPPET SETTING
" let g:completion_enable_snippet = 'vim-vsnip'





""" For LSPS to function, you need to install LSPs!
" Examples
" npm install -g typescript typescript-language-server
" npm install -g pyright
" npm i -g vscode-langservers-extracted
