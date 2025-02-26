set nocompatible
set number
filetype plugin on
syntax on
set nu rnu
set completeopt=menuone,noinsert,noselect
"set shortmess+=c
"set expandtab
set smartindent
"set tabstop=4 softtabstop=4
set cmdheight=2
set signcolumn=yes
"set nobackup
set hidden
"set nowritebackup
set updatetime=300
set clipboard+=unnamedplus
autocmd FileType cpp let termdebugger="gdb"
autocmd FileType rust let termdebugger="rust-gdb"
autocmd FileType python let termdebugger="python -m pdb"
let g:rainbow_active=1
:packadd termdebug
" Add this to your init.vim
let g:termdebug_wide = 1
call plug#begin('~/.nvim/plugged')
Plug 'rust-lang/rust.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree'
Plug 'one-dark/onedark.nvim'
Plug 'frazrepo/vim-rainbow'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
"Plug 'racer-rust/vim-racer'
"Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
"Plug 'junegunn/fzf.vim'
"Plug 'tpope/vim-sensible'
Plug 'ziglang/zig.vim'

call plug#end()
let g:coc_global_extensions = [
      \ 'coc-pyright',
      \ 'coc-snippets',
      \ 'coc-marketplace',
      \ 'coc-prettier',
      \ 'coc-explorer',
      \ 'coc-highlight',
	\ 'coc-clangd',
	\ 'coc-rust-analyzer',
      \ 'coc-tsserver',
      \ 'coc-json',
      \ 'coc-fzf-preview',
        \]
colorscheme onedark
nnoremap <C-f> :NERDTree<CR>
autocmd FileType cpp nnoremap <M-5> <esc>:w<CR>:sp <CR>:term g++ % -Wall -std=c++17 -O2 -o my_program && ./my_program<CR>

autocmd FileType cpp nnoremap <M-9> <esc>:w <CR> :! g++ % -g -std=c++17 -O0 -o my_program<CR>:Termdebug my_program<CR>
autocmd FileType rust nnoremap <M-5> <esc>:Cargo run<CR>
autocmd FileType rust nnoremap <M-9> <esc>:Cargo build<CR>:Termdebug target/debug/my_program<CR>
autocmd FileType python nnoremap <M-5> <esc>:w <CR> :sp <CR> :term python % <CR> 
autocmd FileType python nnoremap <M-9> <esc>:w <CR> :Termdebug % <CR> 
autocmd FileType rust nmap rf :RustFmt <CR>
autocmd FileType java nnoremap <M-5> <esc>:w <CR> :sp <CR> :term java % <CR>
nmap qf <Plug>(coc-fix-current)
nmap cf <Plug>(coc-format)
nmap rn <Plug>(coc-rename)
nmap gd <Plug>(coc-definition)
nmap gy <Plug>(coc-type-definition)
nmap gi <Plug>(coc-implementation)
nmap gr <Plug>(coc-references)
xmap ca <Plug>(coc-codeaction)
nmap ca <Plug>(coc-codeaction)
nmap [g <Plug>(coc-diagnostic-prev)
nmap ]g <Plug>(coc-diagnostic-next)

nnoremap <Leader>dd :call vimspector#Launch()<CR>
nnoremap <Leader>de :call vimspector#Reset()<CR>
nnoremap <Leader>dc :call vimspector#Continue()<CR>

nnoremap <Leader>dt :call vimspector#ToggleBreakpoint()<CR>
nnoremap <Leader>dT :call vimspector#ClearBreakpoints()<CR>

nmap <Leader>dk <Plug>VimspectorRestart
nmap <Leader>dh <Plug>VimspectorStepOut
nmap <Leader>dl <Plug>VimspectorStepInto
nmap <Leader>dj <Plug>VimspectorStepOver



