-- Set nocompatible
vim.cmd('set nocompatible')
vim.cmd('set foldmethod=expr')
vim.cmd('set foldexpr=nvim_treesitter#foldexpr()')
--vim.opt.foldlevel=99

-- Enable line numbers
vim.cmd('set number')

-- Enable filetype plugins and syntax highlighting
vim.cmd('filetype plugin on')
vim.cmd('syntax on')
vim.cmd('set path+=**')
-- Enable relative line numbers
vim.cmd('set nu rnu')

-- Set completeopt options
vim.cmd('set completeopt=menuone,noinsert,noselect')

-- Uncommented lines that you want to enable
-- vim.cmd('set shortmess+=c')
-- vim.cmd('set expandtab')
-- vim.cmd('set smartindent')
-- vim.cmd('set tabstop=4 softtabstop=4')

-- Set command-line height
vim.cmd('set cmdheight=2')

-- Enable sign column
vim.cmd('set signcolumn=yes')

-- Uncommented lines that you want to enable
-- vim.cmd('set nobackup')
-- vim.cmd('set hidden')
-- vim.cmd('set nowritebackup')

-- Set updatetime
vim.cmd('set updatetime=100')

-- Enable clipboard integration
vim.cmd('set clipboard+=unnamedplus')

-- Set terminal debugger based on file type
--vim.cmd('autocmd FileType cpp let termdebugger="lldb"')
--vim.cmd('autocmd FileType rust let termdebugger="rust-lldb"')
--vim.cmd('autocmd FileType python let termdebugger="python -m debugpy"')

-- Enable rainbow parentheses
vim.g.rainbow_active = 1

-- Add termdebug to the pack
vim.g.mkdp_refresh_slow = 1
vim.g.mkdp_echo_preview_url = 1
