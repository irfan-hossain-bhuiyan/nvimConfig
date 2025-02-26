local MdSave = {}
MdSave.config = {
	output_path = vim.fn.getcwd,
	use_wget = false,
	auto_open = false,
}
function MdSave.setup(opts)
	MdSave.config = vim.tbl_deep_extend('force', MdSave.config, opts or {})
end

function MdSave.get_preview_url()
	if vim.g.mkdp_preview_url then
		return vim.g.mkdp_preview_url
	else
		vim.notify("Markdown preview is not running", vim.log.levels.ERROR)
	end
end

function MdSave.save_with_curl(url, output_file)
	local cmd = string.format('curl -s %s > %s', url, output_file)
	vim.fn.system(cmd)
	return vim.v.shell_error == 0
end

function MdSave.save_with_wget(url, output_file)
	local cmd = string.format('wget -O %s %s -q', output_file, url)
	vim.fn.system(cmd)
	return vim.v.shell_error == 0
end

function MdSave.save_as_html()
	local url = MdSave.get_preview_url()
	if not url then return end
	local current_file = vim.fn.expand('%:t:r')
	local output_file = MdSave.config.output_path() .. '/' .. current_file .. '.html'
	local success
	if MdSave.config.use_wget then
		success = MdSave.save_with_wget(url, output_file)
	else
		success = MdSave.save_with_curl(url, output_file)
	end
	if success then
		vim.notify(string.format("Saved HTML to %s", output_file), vim.log.levels.INFO)
		if MdSave.config.auto_open then
			vim.fn.system(string.format("xdg-open %s", output_file))
		end
	else
		vim.notify("Failed to save HTML file!", vim.log.levels.ERROR)
	end
end

vim.api.nvim_create_user_command("MarkdownSaveHTML", function()
    MdSave.save_as_html()
end, {})
return MdSave
