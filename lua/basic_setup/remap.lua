vim.g.mapleader = " "
vim.keymap.set("n", "<leader>ex", vim.cmd.Ex)

function TerminalToggle()
	if vim.bo.buftype == 'terminal' then
		vim.cmd('b#')
	else
		vim.cmd('term')
	end
end

-- Map command abbreviation for Telescope
vim.cmd([[command! -nargs=0 Tterm lua TerminalToggle()]])
-- Auto commands for FileType cpp
vim.cmd([[
  autocmd FileType cpp nnoremap <M-5> <esc>:w<CR>:sp <CR>:term clang++ %  -std=c++20 -opengl -fsanitize=undefined -lraylib -O0 -o my_program && ./my_program<CR>
  autocmd FileType cpp nnoremap <M-9> <esc>:w<CR> :! clang++ % -opengl -lraylib -g -std=c++20  -O0 -o my_program<CR>:DapContinue <CR>my_program<CR>
autocmd FileType cpp nnoremap <M-6> <esc>:w<CR>:sp <CR>:term clang++ %  -std=c++20 -fsanitize=undefined -O0 -o my_program && ./my_program<CR>

  autocmd FileType cpp nnoremap <M-8> <esc>:w<CR> :! clang++ %  -g -std=c++20 -fsanitize=undefined -O0 -o my_program<CR>:DapContinue <CR>my_program<CR>
]])

-- Auto commands for FileType rust
vim.cmd([[
  autocmd FileType rust nnoremap <M-5> <esc>:sp <CR> :!cargo run<CR>
  autocmd FileType rust nnoremap <M-9> <esc>:w <CR> :!cargo build<CR>:DapContinue
]])

-- Auto commands for FileType python
vim.cmd([[
  autocmd FileType python nnoremap <M-5> <esc>:w <CR> :sp <CR> :term python % <CR>
  autocmd FileType python nnoremap <M-9> <esc>:w <CR> :Termdebug % <CR>
]])

-- Auto command for FileType rust (nmap)
vim.cmd([[
  autocmd FileType rust nmap rf :RustFmt <CR>
]])

-- Auto command for FileType java
vim.cmd([[
  autocmd FileType java nnoremap <M-5> <esc>:w <CR> :sp <CR> :term java % <CR>
]])
