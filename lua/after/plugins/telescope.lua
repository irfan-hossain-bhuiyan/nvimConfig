--local builtin = require('telescope.builtin')
--local find_files = builtin.find_files
--local telescope = require('telescope')
--telescope.setup {}
----	defaults = {
----		file_ignore_patterns = { "node_modules", ".git", "build", "dist", "CMakeFiles", "CMakeCache.txt","my_program","a.out","*.out","Resources" }
----	}
----}
--telescope.load_extension "file_browser"
--
--local scandir = require("plenary.scandir")
--vim.keymap.set('n', '<leader>pf', find_files, {})
--local function to_header()
--	local file_name = vim.fn.expand("%:t:r")
--	local file_extension = vim.fn.expand("%:e")
--	local to_file
--	local to_file_path
--	if file_extension == "cpp" then
--		to_file = file_name .. ".hpp"
--		to_file_path="include/"
--	elseif file_extension == "c" then
--		to_file = file_name..".h"
--		to_file_path="include/"
--	elseif file_extension == "h" then
--		to_file = file_name .. ".c"
--		to_file_path="src/"
--	elseif file_extension == "hpp" then
--		to_file = file_name .. ".cpp"
--		to_file_path="src/"
--	end
--	local found_files = scandir.scan_dir(vim.fn.getcwd(), {
--		hidden = false,
--		respect_gitignore = true,
--		depth = 5,
--		search_pattern = to_file
--	})
--	if #found_files > 0 then
--		local relative_path = vim.fn.fnamemodify(found_files[1], ":.")
--		vim.cmd("tabedit " .. relative_path)
--		return
--	else
--		vim.cmd("tabedit " .. to_file_path .. to_file)
--		return
--	end
--end
--vim.api.nvim_create_augroup("CppHeaderToggle", { clear = true })
--
---- Define the autocommands for C++ and header files
--vim.api.nvim_create_autocmd({ "FileType" }, {
--	pattern = {"c", "cpp", "h" },
--	callback = function()
--		-- Set the key mapping for toggling between .cpp and .h files
--		vim.keymap.set('n', '<Leader>eh', to_header, { buffer = true, desc = "Toggle between .cpp ,.c and .h files" })
--	end,
--	group = "CppHeaderToggle"
--})

local builtin = require('telescope.builtin')
local find_files = builtin.find_files
local telescope = require('telescope')
telescope.setup {}
telescope.load_extension "file_browser"

local scandir = require("plenary.scandir")
vim.keymap.set('n', '<leader>pf', find_files, {})

-- Helper function to check if a file is open in any tab
local function switch_to_tab_if_open(filepath)
  -- Expand to full path for comparison consistency
  filepath = vim.fn.fnamemodify(filepath, ":p")
  for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
    local win = vim.api.nvim_tabpage_get_win(tab)
    local buf = vim.api.nvim_win_get_buf(win)
    local bufname = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ":p")
    if bufname == filepath then
      vim.api.nvim_set_current_tabpage(tab)
      return true
    end
  end
  return false
end

local function to_header()
  local file_name = vim.fn.expand("%:t:r")
  local file_extension = vim.fn.expand("%:e")
  local to_file, to_file_path
  if file_extension == "cpp" then
    to_file = file_name .. ".hpp"
    to_file_path = "include/"
  elseif file_extension == "c" then
    to_file = file_name .. ".h"
    to_file_path = "include/"
  elseif file_extension == "h" then
    to_file = file_name .. ".c"
    to_file_path = "src/"
  elseif file_extension == "hpp" then
    to_file = file_name .. ".cpp"
    to_file_path = "src/"
  else
    return
  end

  local found_files = scandir.scan_dir(vim.fn.getcwd(), {
    hidden = false,
    respect_gitignore = true,
    depth = 5,
    search_pattern = to_file
  })

  local target_filepath
  if #found_files > 0 then
    target_filepath = vim.fn.fnamemodify(found_files[1], ":p")
  else
    target_filepath = vim.fn.expand(vim.fn.getcwd() .. "/" .. to_file_path .. to_file)
  end

  -- Check if the file is already open in a tab.
  if not switch_to_tab_if_open(target_filepath) then
    vim.cmd("tabedit " .. target_filepath)
  end
end

vim.api.nvim_create_augroup("CppHeaderToggle", { clear = true })

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "c", "cpp", "h", "hpp" },
  callback = function()
    vim.keymap.set('n', '<Leader>eh', to_header, { buffer = true, desc = "Toggle between .cpp, .c and .h files" })
  end,
  group = "CppHeaderToggle"
})
