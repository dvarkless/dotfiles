---@type MappingsTable

local M = {}
local buf_id = vim.api.nvim_get_current_buf()

M.general = {
  n = {
    [";"] = { ":", "command mode", opts = { nowait = true } },
    ["<C-V>"] = { '"+p', "Paste" },
    ["d"] = { '"_d', "Proper Delete" },
    ["D"] = { '"_D', "Proper Delete" },
    ["<Del>"] = { '"_<DEL>', "Proper Delete" },
    ["<Leader>cv"] = { "*``cgn", "Change variable" },
    ["<Leader>cV"] = { "#``cgN", "Change variable" },
  },

  i = {
    ["jk"] = { "<ESC>", "escape vim" },
    ["<C-V>"] = { '<ESC>"+p<ESC>a', "Paste" },
    ["<Del>"] = { '"_<DEL>', "Proper Delete" },
  },
  v = {
    ["d"] = { '"_d', "Proper Delete" },
    ["D"] = { '"_D', "Proper Delete" },
    ["<C-X>"] = { '"+x', "Cut" },
    ["<S-Del>"] = { '"+x', "Cut" },
    ["<C-C>"] = { '"+y', "Copy" },
    ["<C-Insert>"] = { '"+p', "Paste" },
    ["<Del>"] = { '"_<DEL>', "Proper Delete" },
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

M.jupynium = {
  n = {
    ["<leader><leader>"] = { "<cmd>JupyniumExecuteSelectedCells<CR>", opts = { buffer = buf_id }, "Jupynium run cell" },
    ["<leader>co"] = {
      "<cmd>JupyniumClearSelectedCellsOutputs<CR>",
      opts = { buffer = buf_id },
      "Jupynium clear selected cells",
    },
    ["<leader>K"] = {
      "<cmd>JupyniumKernelHover<CR>",
      opts = { buffer = buf_id },
      "Jupynium hover (inspect a variable)",
    },
    ["<leader>js"] = { "<cmd>JupyniumScrollToCell<cr>", opts = { buffer = buf_id }, "Jupynium scroll to cell" },
    ["<PageDown>"] = { "<cmd>JupyniumScrollDown<cr>", opts = { buffer = buf_id }, "Jupynium scroll down" },
    ["<PageUp>"] = { "<cmd>JupyniumScrollUp<cr>", opts = { buffer = buf_id }, "Jupynium scroll up" },
  },
  v = {

    ["<leader><leader>"] = { "<cmd>JupyniumExecuteSelectedCells<CR>", opts = { buffer = buf_id }, "Jupynium run cell" },
    ["<leader>co"] = {
      "<cmd>JupyniumClearSelectedCellsOutputs<CR>",
      opts = { buffer = buf_id },
      "Jupynium clear selected cells",
    },
    ["<leader>K"] = {
      "<cmd>JupyniumKernelHover<CR>",
      opts = { buffer = buf_id },
      "Jupynium hover (inspect a variable)",
    },
    ["<leader>js"] = { "<cmd>JupyniumScrollToCell<cr>", opts = { buffer = buf_id }, "Jupynium scroll to cell" },
    ["<PageDown>"] = { "<cmd>JupyniumScrollDown<cr>", opts = { buffer = buf_id }, "Jupynium scroll down" },
    ["<PageUp>"] = { "<cmd>JupyniumScrollUp<cr>", opts = { buffer = buf_id }, "Jupynium scroll up" },
  },
  i = {
    ["<PageDown>"] = { "<cmd>JupyniumScrollDown<cr>", opts = { buffer = buf_id }, "Jupynium scroll down" },
    ["<PageUp>"] = { "<cmd>JupyniumScrollUp<cr>", opts = { buffer = buf_id }, "Jupynium scroll up" },
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
