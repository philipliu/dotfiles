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
        require('config.theme').setup()
      end,
    }

    use {
      "kyazdani42/nvim-web-devicons",
      after = "github-nvim-theme",
      config = function()
        require("nvim-web-devicons").setup{ default = true }
      end
    }

    use { "nvim-lua/plenary.nvim" }

    use {
      "nvim-telescope/telescope.nvim",
      requires = { 'nvim-lua/plenary.nvim' },
      config = function()
        require("config.telescope").setup()
      end,
    }

    use {
      'romgrk/barbar.nvim',
      requires = { 'kyazdani42/nvim-web-devicons' },
      config = function()
        require("config.barbar").setup()
      end
    }

    use {
      "nvim-lualine/lualine.nvim",
      after = "github-nvim-theme",
      config = function()
        require("config.lualine").setup()
      end,
    }

    use {
      "kyazdani42/nvim-tree.lua",
      requires = { "kyazdani42/nvim-web-devicons" },
      config = function()
        require("config.nvimtree").setup()
      end,
    }

    use {
      "neovim/nvim-lspconfig",
      config = function()
        require("config.lsp").setup()
        require("config.lsp").setup_rust()
      end,
    }

    use {
      "hrsh7th/nvim-cmp",
      config = function()
        require("config.cmp").setup()
      end,
    }
    use { "hrsh7th/cmp-nvim-lsp" }
    use { "hrsh7th/cmp-vsnip" }
    use { "hrsh7th/cmp-path" }
    use { "hrsh7th/cmp-buffer" }
    use { "hrsh7th/vim-vsnip" }
    use { "simrat39/rust-tools.nvim" }

    use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      config = function()
        require("config.treesitter").setup()
      end
    }

    use {
      'lewis6991/gitsigns.nvim',
      config = function()
        require('gitsigns').setup()
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
