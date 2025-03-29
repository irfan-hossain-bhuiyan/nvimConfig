local lsp_zero = require('lsp-zero')
require('after.plugins.snippet')
-- Add cmp_nvim_lsp capabilities settings to lspconfig
-- This should be executed before you configure any language server
local lspconfig_defaults = require('lspconfig').util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
	'force',
	lspconfig_defaults.capabilities,
	require('cmp_nvim_lsp').default_capabilities()
)

--lua api setup for lsp
lsp_zero.on_attach(function(client, bufnr)
	local opt = { buffer = bufnr }
	-- see :help lsp-zero-keybindings
	-- to learn the available actions
	lsp_zero.default_keymaps(opt)
	vim.keymap.set("n", "qf", function() vim.lsp.buf.code_action() end, opt)
	vim.keymap.set("n", "rn", function() vim.lsp.buf.rename() end, opt)
	vim.keymap.set("n", "cf", function() vim.lsp.buf.format() end, opt)
	vim.keymap.set("i", "<C-s>", function() vim.lsp.buf.signature_help() end, opt)
	--vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
	--vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
	--vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
	--vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
	--vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
	--vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
	--vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
	--vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
	--vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
	--vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
end)
require 'lspconfig'.ts_ls.setup {}
require 'lspconfig'.clangd.setup {}
require 'lspconfig'.neocmake.setup {}
require 'lspconfig'.rust_analyzer.setup {}
require 'lspconfig'.pyright.setup {}
require('lspconfig').lua_ls.setup {
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using
				version = 'LuaJIT',
			},
			flags = {
				debounce_text_changes = 150, -- Delay LSP requests while typing
			},
			workspace = {
				-- Make the server aware of LÖVE runtime files
				library = {
					[vim.fn.expand('$VIMRUNTIME/lua')] = true,
					[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
					['${3rd}/love2d/library'] = true,
				},
				-- Disable third-party library checking for the restricted folder
				checkThirdParty = false,
				-- Adjust these if needed
				maxPreload = 2000,
				preloadFileSize = 10000,
			},
			telemetry = {
				enable = false, -- Disable telemetry for privacy
			},
		},
	},
}
local cmp = require('cmp')
local cmp_format = lsp_zero.cmp_format()
local cmp_action = lsp_zero.cmp_action()

cmp.setup({
	sources = { { name = 'nvim_lsp' }, { name = 'buffer' }, { name = 'path' }, { name = 'luasnip' } },
	formatting = cmp_format,
	mapping = cmp.mapping.preset.insert({
		-- `Enter` key to confirm completion
		['<C-y>'] = cmp.mapping.confirm({ select = true }),
		-- Ctrl+Space to trigger completion menu
		--  ['<C-n>'] = cmp.mapping.complete(),
		-- Navigate between snippet placeholder
		['<M-Up>'] = cmp.mapping.scroll_docs(-10),
		['<M-Down>'] = cmp.mapping.scroll_docs(10),

		['<Tab>'] = cmp_action.luasnip_jump_forward(),
		['<S-Tab>'] = cmp_action.luasnip_jump_backward(),
	}),
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
			--vim.snippet.expand(args.body)
		end,
	}
})
