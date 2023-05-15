local M = {}

M.treesitter = {
  ensure_installed = {
    "vim",
    "lua",
    "html",
    "css",
    "c",
    "markdown",
    "markdown_inline",
    "python",
    "cpp",
    "cuda",
    "arduino",
    "sql",
  },
  indent = {
    enable = true,
    disable = {
      "python",
    },
  },
}

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",
    "pyright",

    -- web dev stuff
    "css-lsp",
    "html-lsp",
  },
}

-- git support in nvimtree
M.nvimtree = {
  git = {
    enable = true,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}
local cmp = require "cmp"

M.cmp = {
  sources = {
    { name = "jupynium", priority = 1000 }, -- consider higher priority than LSP
    { name = "nvim_lsp", priority = 100 },
    { name = "crates"},
    -- ...
  },
  sorting = {
    priority_weight = 1.0,
    comparators = {
      cmp.config.compare.score, -- Jupyter kernel completion shows prior to LSP
      cmp.config.compare.recently_used,
      cmp.config.compare.locality,
      -- ...
    },
  },
}
return M
