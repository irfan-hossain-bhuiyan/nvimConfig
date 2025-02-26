-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	-- Packer can manage itself
	-- This one is used to give notification in neovim.
	-- use 'j-hui/fidget.nvim'
	use {
		'nvim-telescope/telescope.nvim',
		-- or                            , branch = '0.1.x',
		requires = { { 'nvim-lua/plenary.nvim' } }
	}
	use({ 'rose-pine/neovim', as = 'rose-pine', config = function() vim.cmd('colorscheme rose-pine') end })
	use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
	use 'mbbill/undotree'
	use {
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v3.x',
		requires = {
			--- Uncomment these if you want to manage LSP servers from neovim

			--  {'williamboman/mason.nvim'},
			--  {'williamboman/mason-lspconfig.nvim'},
			-- LSP Support
			{ 'neovim/nvim-lspconfig' },
			-- Autocompletion
			{ 'hrsh7th/nvim-cmp' },
			{ 'hrsh7th/cmp-nvim-lsp' },
			{ 'L3MON4D3/LuaSnip' },
			{ 'hrsh7th/cmp-path' },
			{ 'hrsh7th/cmp-buffer' },
			{ 'saadparwaiz1/cmp_luasnip'},

		}
	}
	use { 'iamcco/markdown-preview.nvim' }
	--use({
	--    "iamcco/markdown-preview.nvim",
	--    run = function() vim.fn["mkdp#util#install"]() end,
	--})
	--use {'iamcco/markdown-preview.nvim'}
	use 'simrat39/rust-tools.nvim'
	use 'mfussenegger/nvim-dap'
	use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } }
	use { "Weyaaron/nvim-training" }
	use "nvim-telescope/telescope-file-browser.nvim"
	use "xemptuous/sqlua.nvim"
end)
