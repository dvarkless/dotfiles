---@type MappingsTable

local M = {}

M.general = {
    n = {
        [";"] = { ":", "command mode", opts = { nowait = true } },
        ['<C-V>'] = {'"+p', 'Delete without copying'},
        ['d'] = {'"_d', 'Proper Delete'},
        ['D'] = {'"_D', 'Proper Delete'},
        [';;'] = {':%s:::g<Left><Left><Left>', 'Subtitude word'},
        [";'"] = {':%s:::gc<Left><Left><Left><Left>', 'Subtitude word'},
        ["cp"] = {'yap<S-}>p', 'Copy paragraph'},
        ["<Leader>cv"] = {"*``cgn", 'Change variable'},
        ["<Leader>cV"] = {"#``cgN", 'Change variable'},

},

    i = {
        ["jk"] = { "<ESC>", "escape vim" },
        ['<C-V>'] = {'<ESC>"+p<ESC>a', 'Paste'},
    },
    v = {
        ['d'] = {'"_d', 'Proper Delete'},
        ['D'] = {'"_D', 'Proper Delete'},
        ['<C-X>'] = {'"+x', 'Cut'},
        ['<S-Del>'] = {'"+x', 'Cut'},
        ['<C-C>'] = {'"+p', 'Paste'},
        ['<C-Insert>'] = {'"+p', 'Paste'},
    },
}

M.truzen = {
  n = {
    ["<leader>ta"] = { "<cmd> TZAtaraxis <CR>", "truzen ataraxis" },
    ["<leader>tm"] = { "<cmd> TZMinimalist <CR>", "truzen minimal" },
    ["<leader>tf"] = { "<cmd> TZFocus <CR>", "truzen focus" },
  },
}

M.treesitter = {
  n = {
    ["<leader>cu"] = { "<cmd> TSCaptureUnderCursor <CR>", "find media" },
  },
}

M.shade = {
  n = {
    ["<leader>s"] = {
      function()
        require("shade").toggle()
      end,

      "toggle shade.nvim",
    },
  },
}

M.nvterm = {
  n = {
    ["<leader>cc"] = {
      function()
        require("nvterm.terminal").send("clear && g++ -o out " .. vim.fn.expand "%" .. " && ./out", "vertical")
      end,

      "compile & run a cpp file",
    },
  },
}

return M
