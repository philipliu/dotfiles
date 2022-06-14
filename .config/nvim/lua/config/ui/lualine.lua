local M = {}

function M.setup()
  require('lualine').setup {
    options = {
      theme = "auto",
    },
    extensions = {
      "nvim-tree",
      "toggleterm"
    },
    sections = {
      lualine_c = {}
    },
    inactive_sections = {
      lualine_c = {}
    }
  }

end

return M
