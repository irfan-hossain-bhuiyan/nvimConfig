local dap = require('dap')
local dapUi = require('dap.ui.widgets')
local dapui = require('dapui')
dapui.setup(
	{
		controls = {
			element = "repl",
			enabled = true,
			icons = {
				disconnect = "",
				pause = "",
				play = "",
				run_last = "",
				step_back = "",
				step_into = "",
				step_out = "",
				step_over = "",
				terminate = ""
			}
		},
		element_mappings = {},
		expand_lines = true,
		floating = {
			border = "single",
			mappings = {
				close = { "q", "<Esc>" }
			}
		},
		force_buffers = true,
		icons = {
			collapsed = "",
			current_frame = "",
			expanded = ""
		},
		layouts = { {
			elements = { {
				id = "scopes",
				size = 0.25
			},
				-- {
				--   id = "breakpoints",
				--   size = 0.25
				-- },
				{
					id = "stacks",
					size = 0.25
				}, {
				id = "watches",
				size = 0.25
			} },
			position = "left",
			size = 20
		},
			{
				elements = { {
					id = "console",
					size = 1
				} },
				position = "bottom",
				size = 10
			}
		},
		mappings = {
			edit = "e",
			expand = { "<CR>", "<2-LeftMouse>" },
			open = "o",
			remove = "d",
			repl = "r",
			toggle = "t"
		},
		render = {
			indent = 1,
			max_value_lines = 100
		}
	}

)
dap.adapters.lldb = {
	type = 'executable',
	command = '/data/data/com.termux/files/usr/bin/lldb-dap', -- adjust as needed, must be absolute path
	name = 'lldb'
}

--c++ ,c configaration
dap.configurations.cpp = {
	{
		name = 'cpp_config',
		type = 'lldb',
		request = 'launch',
		program = function()
			return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
		end,
		cwd = '${workspaceFolder}',
		stopOnEntry = false,
		args = {},

		-- 💀
		-- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
		--
		--    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
		--
		-- Otherwise you might get the following error:
		--
		--    Error on launch: Failed to attach to the target process
		--
		-- But you should be aware of the implications:
		-- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
		runInTerminal = true,
	},
}

-- If you want to use this for Rust and C, add something like this:

dap.configurations.c = dap.configurations.cpp

-- Rust configration
dap.configurations.rust = {
	{
		name = 'Launch',
		type = 'lldb',
		request = 'launch',
		program = function()
			return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
		end,
		cwd = '${workspaceFolder}',
		stopOnEntry = false,
		args = {},
		initCommands = function()
			-- Find out where to look for the pretty printer Python module
			local rustc_sysroot = vim.fn.trim(vim.fn.system('rustc --print sysroot'))

			local script_import = 'command script import "' ..
			    rustc_sysroot .. '/lib/rustlib/etc/lldb_lookup.py"'
			local commands_file = rustc_sysroot .. '/lib/rustlib/etc/lldb_commands'

			local commands = {}
			local file = io.open(commands_file, 'r')
			if file then
				for line in file:lines() do
					table.insert(commands, line)
				end
				file:close()
			end
			table.insert(commands, 1, script_import)

			return commands
		end,
	},
}
dap.adapters.python = {
	type = 'executable',
	command = 'python',
	args = { '-m', 'debugpy.adapter' },
}
dap.configurations.python = {
	{
		type = 'python',
		request = 'launch',
		name = "Launch file",
		console = "integratedTerminal",
		program = "${file}",
		pythonPath = function()
			return '/data/data/com.termux/files/usr/bin/python'
		end,
	},
}
dap.adapters["local-lua"] = {
  type = "executable",
  command = "node",
  args = {
    "~/local-lua-debugger-vscode/extension/debugAdapter.js"
  },
  enrich_config = function(config, on_config)
    if not config["extensionPath"] then
      local c = vim.deepcopy(config)
      -- 💀 If this is missing or wrong you'll see 
      -- "module 'lldebugger' not found" errors in the dap-repl when trying to launch a debug session
      c.extensionPath = "~/local-lua-debugger-vscode/"
      on_config(c)
    else
      on_config(config)
    end
  end,
}
dap.configurations.lua = {
  {
    name = 'local-lua-dbg',
    type = 'local-lua',
    request = 'launch',
    cwd = '${workspaceFolder}',
    program = {
      lua = 'lua5.1',
      file = '${file}',
    },
    args = {},
  },
}
--add some mapping
vim.keymap.set("n", "<leader>br", function() dap.toggle_breakpoint() end)
vim.keymap.set("n", "<leader>co", function() dap.continue() end)
vim.keymap.set("n", "<leader>so", function() dap.step_over() end)
vim.keymap.set("n", "<leader>si", function() dap.step_into() end)
vim.keymap.set("n", "<leader>v", function() dapUi.hover() end)
vim.keymap.set("n", "<leader>pv", function() dapUi.preview() end)
vim.keymap.set('n', '<leader>rp', function() dap.repl.open() end)
vim.keymap.set("n", "<leader>vv", function() dapUi.centered_float(dapUi.frames) end)
vim.keymap.set("n", "<leader>du", function() dapui.toggle() end)
