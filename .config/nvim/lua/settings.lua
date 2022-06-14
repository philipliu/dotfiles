local opt = vim.opt

opt.syntax = "on"
opt.number = true
opt.enc = "utf-8"
opt.ruler = true
opt.expandtab = true
opt.backspace = "2"
opt.tabstop = 4
opt.shiftwidth = 4
opt.smarttab = true
opt.autoindent = true
opt.visualbell = true
opt.hlsearch = true
opt.termguicolors = true
opt.mouse = "a"
opt.signcolumn = "yes"
opt.fillchars = {
	vert = " ", -- alternatives │
	fold = " ",
	eob = " ", -- suppress ~ at EndOfBuffer
	diff = "╱", -- alternatives = ⣿ ░ ─
	msgsep = "‾",
	foldopen = "▾",
	foldsep = "│",
	foldclose = "▸",
}
opt.showmode = false
