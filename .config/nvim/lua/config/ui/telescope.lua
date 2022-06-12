local M = {}
local keymap = vim.keymap

function M.setup()
  local ok, telescope = pcall(require, "telescope")
  if not ok then
    return
  end

  telescope.setup {}

  local builtin = require "telescope.builtin"

  keymap.set("n", "<leader>ff", builtin.find_files)
  keymap.set("n", "<leader>fg", builtin.live_grep)
  keymap.set("n", "<leader>fb", builtin.buffers)
  keymap.set("n", "<leader>fh", builtin.help_tags)
end

return M
