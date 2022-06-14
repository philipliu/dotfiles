local M = {}

function M.setup()
  -- Indicate first time installation
  local packer_bootstrap = false

  -- packer.nvim configuration
  local conf = {
    display = {
      open_fn = function()
        return require("packer.util").float { border = "rounded" }
      end,
    },
  }

  -- Check if packer.nvim is installed
  -- Run PackerCompile if there are changes in this file
  local function packer_init()
    local fn = vim.fn
    local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
      packer_bootstrap = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
      }
      vim.cmd [[packadd packer.nvim]]
    end
    vim.cmd "autocmd BufWritePost plugins.lua source <afile> | PackerCompile"
  end

  -- Plugins
  local function plugins(use)
    use { "wbthomason/packer.nvim" }

    use {
      "projekt0n/github-nvim-theme",
      config = function()
        require('config.ui.theme').setup()
      end,
    }

    use {
      "kyazdani42/nvim-web-devicons",
      config = function()
        require("nvim-web-devicons").setup { default = true }
      end
    }

    use { "nvim-lua/plenary.nvim" }

    use {
      "nvim-telescope/telescope.nvim",
      requires = { 'nvim-lua/plenary.nvim' },
      config = function()
        require("config.ui.telescope").setup()
      end,
    }

    use {
      'romgrk/barbar.nvim',
      requires = { 'kyazdani42/nvim-web-devicons' },
      config = function()
        require("config.ui.barbar").setup()
      end
    }

    use {
      "nvim-lualine/lualine.nvim",
      after = "github-nvim-theme",
      config = function()
        require("config.ui.lualine").setup()
      end,
    }

    use {
      "kyazdani42/nvim-tree.lua",
      requires = { "kyazdani42/nvim-web-devicons" },
      config = function()
        require("config.ui.nvimtree").setup()
      end,
    }

    use {
      "neovim/nvim-lspconfig",
      config = function()
        require("config.lsp.lsp").setup()
        require("config.lsp.lsp").setup_rust()
      end,
    }

    use { "onsails/lspkind.nvim" }

    use {
      "hrsh7th/nvim-cmp",
      requires = { "onsails/lspkind.nvim" },
      config = function()
        require("config.lsp.cmp").setup()
      end,
    }
    use { "hrsh7th/cmp-nvim-lsp" }
    use { "hrsh7th/cmp-vsnip" }
    use { "hrsh7th/cmp-path" }
    use { "hrsh7th/cmp-buffer" }
    use { "hrsh7th/vim-vsnip" }
    use { "simrat39/rust-tools.nvim" }

    use {
      "folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require("config.lsp.trouble").setup()
      end
    }

    use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      config = function()
        require("config.util.treesitter").setup()
      end
    }

    use {
      'lewis6991/gitsigns.nvim',
      config = function()
        require('config.ui.gitsigns').setup()
      end
    }

    use {
      "akinsho/toggleterm.nvim", tag = 'v1.*',
      config = function()
        require("config.util.toggleterm").setup()
      end
    }

    use {
      "mrjones2014/legendary.nvim",
      config = function()
        require("config.util.legendary").setup()
      end
    }

    use {
      "stevearc/dressing.nvim",
      config = function()
        require("config.ui.dressing").setup()
      end
    }

    use {
      "folke/which-key.nvim",
      config = function()
        require("config.util.whichkey").setup()
      end
    }

    use {
      "lukas-reineke/indent-blankline.nvim",
      config = function()
        require("config.ui.indent_blankline").setup()
      end
    }

    use {
      "windwp/nvim-autopairs",
      config = function()
        require("config.util.autopairs").setup()
      end
    }

    use {
      "terrortylor/nvim-comment",
      config = function()
        require("config.util.comment").setup()
      end
    }

    if packer_bootstrap then
      print "Restart Neovim required after installation!"
      require("packer").sync()
    end
  end

  packer_init()

  local packer = require "packer"
  packer.init(conf)
  packer.startup(plugins)
end

return M
