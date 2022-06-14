local M = {}

function M.setup()
	vim.opt.list = true
	vim.opt.listchars:append("eol:↴")

	require("indent_blankline").setup {
		show_end_of_line = true,
	}
end

return M
