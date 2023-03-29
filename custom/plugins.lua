local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
return {

  -- Override plugin definition options
  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
      {
        "williamboman/mason.nvim",
        config = function(_, opts)
          dofile(vim.g.base46_cache .. "mason")
          require("mason").setup(opts)
          vim.api.nvim_create_user_command("MasonInstallAll", function()
            vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
          end, {})
          require "plugins.configs.lspconfig"
          require "custom.configs.lspconfig" -- Load in lsp config
        end,
      },
      "williamboman/mason-lspconfig.nvim",
    },
    config = function() end, -- Override to setup mason-lspconfig
  },
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "jose-elias-alvarez/null-ls.nvim",
    },
    config = function()
      require "custom.configs.null-ls" -- require your null-ls config here (example below)
    end,
  },
  -- overrde plugin configs
  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "Pocco81/TrueZen.nvim",
    cmd = {
      "TZAtaraxis",
      "TZMinimalist",
      "TZFocus",
    },
    config = function()
      require "custom.configs.truezen"
    end,
  },

  -- get highlight group under cursor
  {
    "nvim-treesitter/playground",
    cmd = "TSCaptureUnderCursor",
    config = function() end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  {
    "nvim-telescope/telescope-media-files.nvim",
    requires = "nvim-telescope/telescope.nvim",
    after = "nvim-telescope/telescope.nvim",
    config = function()
      require "custom.configs.telescope-media"
    end,
  },
  ------------------- MISC GENERAL --------------------------------
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },
  {
    "folke/which-key.nvim",
    lazy = false,
    disable = false,
  },

  {
    "rcarriga/nvim-notify",
    lazy = false,
    config = function()
      require "custom.configs.notify"
    end,
  },
  {
    "kylechui/nvim-surround",
    -- tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    lazy = false,
    config = function()
      require("nvim-surround").setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },
  ------------------------ DEBUG -----------------------------
  {
    "mfussenegger/nvim-dap",
    lazy = false,
    enabled = true,
    config = function()
      require "custom.configs.dap"
    end,
  },
  {
    "mfussenegger/nvim-dap-python",
    requires = "mfussenegger/nvim-dap",
    lazy = false,
    enabled = true,
    config = function()
      require "custom.configs.dap-python"
    end,
  },

  {
    "rcarriga/nvim-dap-ui",
    requires = "mfussenegger/nvim-dap",
    lazy = false,
    enabled = true,
    config = function()
      require "custom.configs.dap-ui"
    end,
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    requires = "mfussenegger/nvim-dap",
    lazy = false,
    enabled = true,
    config = function()
      require "custom.configs.dap-text"
    end,
  },

  {
    "folke/neodev.nvim",
    requires = "rcarriga/nvim-dap-ui",
    config = function()
      require "custom.configs.neodev"
    end,
  },
  {
    "nvim-neotest/neotest",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
    },
    config = function()
      require "custom.configs.neotest"
    end,
  },
  ----------------- JUPYTER CONFIG ---------------------------
  {
    "kiyoon/jupynium.nvim",
    build = "pip install --user .",
    lazy = false,
    config = function()
      require "custom.configs.jupynium"
    end,
    -- build = "conda run --no-capture-output -n jupynium pip install .",
    -- enabled = vim.fn.isdirectory(vim.fn.expand "~/miniconda3/envs/jupynium"),
  },

  { "hrsh7th/nvim-cmp", opts = overrides.cmp },

  "stevearc/dressing.nvim",
  ----------------------------------------------------------------------
  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },
}
