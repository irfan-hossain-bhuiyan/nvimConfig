local ts_utils = require('nvim-treesitter.ts_utils')

local function getEnumCases(bufnr)
	local parser = vim.treesitter.get_parser(bufnr, 'c')
	local tree = parser:parse()[1]
	local root = tree:root()
	local query = vim.treesitter.query.parse('c', [[
(type_definition
      type: (enum_specifier
              body: (enumerator_list
                      (enumerator
                        name: (identifier) @enum.case))
	)
	declarator: (type_identifier) @enum.name
)
	]])
	local cases = {}
	local currentElements={}
	for id, node in query:iter_captures(root, bufnr) do
		local captureType = query.captures[id]
		local captureText = vim.treesitter.get_node_text(node,bufnr)
		if captureType=='enum.name' then
			if cases[captureText]~=nil then
				goto continue
			end
			cases[captureText]=currentElements
			currentElements={}
		elseif captureType=='enum.case' then
			table.insert(currentElements,captureText)
		else
			vim.notify("code is modified,but the function didn't got updated",vim.log.levels.WARN)
		end
	    ::continue::
	end
	return cases
end
local function test()
	local bufnr =vim.api.nvim_get_current_buf()
	local parser = vim.treesitter.get_parser(bufnr, 'c')
	local tree = parser:parse()[1]
	local root = tree:root()
	local query = vim.treesitter.query.parse('c', [[
(type_definition
      type: (enum_specifier
              body: (enumerator_list
                      (enumerator
                        name: (identifier) @enum.case))
	)
	declarator: (type_identifier) @enum.name
)
	]])
	for id, node in query:iter_captures(root, bufnr) do
		local captureType = query.captures[id]
		local captureText = vim.treesitter.get_node_text(node,bufnr)
		print(captureType.." : "..captureText)
	end
end

local function parseDebug()
	local bufnm = vim.api.nvim_get_current_buf()
	local parsedTable = getEnumCases(bufnm)
	print(vim.inspect(parsedTable))
end
vim.api.nvim_create_user_command('EnumParse', parseDebug, {})
vim.api.nvim_create_user_command('Test', test, {})
