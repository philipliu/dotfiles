local M = {}

function M.setup()
	require("toggleterm").setup({
		open_mapping = [[<c-\>]],
		shade_terminals = true,
	})
end

return M
