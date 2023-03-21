---@type MappingsTable

local M = {}
local buf_id = vim.api.nvim_get_current_buf()

M.general = {
  n = {
    [";"] = { ":", "command mode", opts = { nowait = true } },
    ["<C-V>"] = { '"+p', "Paste" },
    ["d"] = { '"_d', "Proper Delete" },
    ["D"] = { '"_D', "Proper Delete" },
    ["<Del>"] = { '"_x', "Proper Delete" },
    ["<Leader>cv"] = { "*``cgn", "Change variable" },
    ["<Leader>cV"] = { "#``cgN", "Change variable" },
  },

  i = {
    ["jk"] = { "<ESC>", "escape vim" },
    ["<C-V>"] = { '<ESC>"+p<ESC>a', "Paste" },
    ["<Del>"] = { '"_<Del>', "Proper Delete" },
  },
  v = {
    ["d"] = { '"_d', "Proper Delete" },
    ["D"] = { '"_D', "Proper Delete" },
    ["<C-X>"] = { '"+x', "Cut" },
    ["<S-Del>"] = { '"+x', "Cut" },
    ["<C-C>"] = { '"+y', "Copy" },
    ["<C-Insert>"] = { '"+p', "Paste" },
    ["<Del>"] = { '"_<Del>', "Proper Delete" },
  },
}

M.dap = {
    n = {
    ["<leader>dd"] = { "<cmd> DapToggleBreakpoint <CR>", "Dap toggle breakpoint" },
    ["<F5>"] = { "<cmd> DapContinue <CR>", "Dap continue" },
    ["<F9>"] = { "<cmd> DapStepOver <CR>", "Dap Step over" },
    ["<F10>"] = { "<cmd> DapStepInto <CR>", "Dap Step into" },
    ["<F11>"] = { "<cmd> DapStepOut <CR>", "Dap Step out" },
    ["<leader>dl"] = { "<cmd> DapTerminate <CR>", "Dap terminate" },
    ["<leader>dr"] = { "<cmd> DapToggleRepl<CR>", "Dap toggle breakpoint" },
    ["<leader>ld"] = { "<cmd> DapShowLog<CR>", "Dap show log" },
    ["<leader>dK"] = { '<Cmd>lua require("dap.ui.widgets").hover()<CR>', opts = { silent = true }, "Dap variable definition" },
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
    ["<leader>fo"] = {
        function ()
            vim.lsp.buf.code_action()
        end,
        'LSP Code action',
        }
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
