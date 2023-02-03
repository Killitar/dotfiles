local fn = vim.fn
-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

pcall(require, "impatient") -- Call impatient plugin before all others to improve performance. Keep this line here.

-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

-- Install your plugins here
return packer.startup(function(use)
  ---------------------
  -- Package Manager --
  ---------------------
  use("wbthomason/packer.nvim") -- Packer manage itself

  ----------------------
  -- Required plugins --
  ----------------------
  -- Improve startup time (source: https://alpha2phi.medium.com/neovim-for-beginners-performance-95687714c236)
  use("lewis6991/impatient.nvim")
  use("nvim-lua/plenary.nvim")
  use({
    'kyazdani42/nvim-web-devicons',
    config = function()
      require('nvim-web-devicons').setup()
    end,
  })
  ----------------------
  -- General --
  ----------------------

  --Smooth scrolling
  use({
    'karb94/neoscroll.nvim',
    event = 'WinScrolled',
    config = function()
      require('neoscroll').setup()
    end,
  })

  --Colorscheme
  use({
    'ellisonleao/gruvbox.nvim',
    config = function()
      require('plugins.gruvbox')
    end
  })

  --Bufferline
  use({
    'akinsho/bufferline.nvim',
    config = function()
      require('plugins.bufferline')
    end
  })

  --Lualine
  use({
    'nvim-lualine/lualine.nvim',
    config = function()
      require('plugins.lualine')
    end
  })
  -- Electric indentation
  use {
    'nmac427/guess-indent.nvim',
    config = function() require('guess-indent').setup {} end,
  }

  --------------------------------------
  -- File Navigation and Fuzzy Search --
  --------------------------------------
  use({
    {
      'nvim-telescope/telescope.nvim',
      config = function()
        require('plugins.telescope')
      end,
    },
    {
      'nvim-telescope/telescope-file-browser.nvim',
    },
    {
      "ahmedkhalf/project.nvim",
    }
  })

  -----------------------------------
  -- Treesitter --
  -----------------------------------

  -- Treesitter
  use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }) -- Syntax highlighting
  -- use("nvim-treesitter/nvim-treesitter-textobjects") -- Extra text objects for better selecting
  use({
    "windwp/nvim-ts-autotag",
    config = function()
      require('nvim-ts-autotag').setup({})
    end
  }) -- Auto close tags
  use({
    "windwp/nvim-autopairs",
    config = function()
      require('nvim-autopairs').setup({
        disable_filetype = { 'TelescopePromt', 'vim' }
      })
    end
  }) -- Autoclose quotes, parentheses etc.


  --------------------------------------
  -- LSP --
  --------------------------------------
  -- LSP
  use({
    'neovim/nvim-lspconfig',
    config = function()
      require('plugins.lsp')
    end,
    requires = {
      {
        -- WARN: Unfortunately we won't be able to lazy load this
        'hrsh7th/cmp-nvim-lsp',
      },
    },
  })

  use({ "williamboman/mason.nvim" }) -- New LSP Installer
  use({ "williamboman/mason-lspconfig.nvim" }) -- New LSP server Installer
  use({
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
      require('plugins.null-ls')
    end
  })

  use({
    'glepnir/lspsaga.nvim',
    config = function()
      require('plugins.lsp')
    end
  })

  --LSP Diagnostics
  use({
    "folke/trouble.nvim",
    requires = "nvim-tree/nvim-web-devicons",
    cmd = 'TroubleToggle',
    config = function()
      require("trouble").setup {
      }
    end
  })
  -------------------------------------
  -- Autocompletion --
  --------------------------------------

  --Snippets
  use('L3MON4D3/LuaSnip')
  use('rafamadriz/friendly-snippets')

  use({
    {
      'hrsh7th/nvim-cmp',
      event = 'InsertEnter',
      config = function()
        require('plugins.cmp')
      end,
      requires = {
        {
          'L3MON4D3/LuaSnip',
          requires = {
            {
              'rafamadriz/friendly-snippets',
            },
          },
        },
      },
    },
    { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
    { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
    { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
  })

  --------------------------------------
  -- Editing Enhancements --
  --------------------------------------

  --Show colors
  use({ "norcalli/nvim-colorizer.lua", event = "CursorHold",
    config = function()
      require 'colorizer'.setup()
    end
  })

  use({
    'axelvc/template-string.nvim',
    config = function()
      require('template-string').setup({
        filetypes = { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact', 'python' }, -- filetypes where the plugin is active
        jsx_brackets = true, -- must add brackets to jsx attributes
        remove_template_string = false, -- remove backticks when there are no template string
        restore_quotes = {
          -- quotes used when "remove_template_string" option is enabled
          normal = [[']],
          jsx = [["]],
        }
      })
    end
  })
  --
  --
  --Comment nvim
  use({
    'numToStr/Comment.nvim',
    requires = {
      'JoosepAlviste/nvim-ts-context-commentstring'
    },
    config = function()
      require('plugins.comment')
    end
  })
  use({
    'mg979/vim-visual-multi',
    'tpope/vim-surround',
    'gcmt/wildfire.vim'
  })

  use({
    'folke/todo-comments.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      require('todo-comments').setup({})
    end
  })


  --MARKDOWN
  use({ "dkarter/bullets.vim", ft = "markdown" }) -- Automatic ordered lists. For reordering messed list, use :RenumberSelection cmd
  use({
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    setup = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  }) --Markdown preview
  use({ "jghauser/follow-md-links.nvim", ft = "markdown" }) --Follow md links with ENTER

end
)
