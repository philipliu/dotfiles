local M = {}

function M.setup()
	local wk = require("which-key")
	wk.setup {}

	wk.register({
		f = {
			name = "file",
			f = { "<cmd>Telescope find_files<cr>", "Find file" },
			g = { "<cmd>Telescope live_grep<cr>", "Live grep" },
			b = { "<cmd>Telescope buffers<cr>", "Find in buffers" },
			h = { "<cmd>Telescope help_tags<cr>", "Search help tags" }
		},
	}, { prefix = "<leader>" })
end

return M
