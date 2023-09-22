local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local util = require "lspconfig/util"

local DEFAULT_FQBN = "arduino:avr:nano"

local my_arduino_fqbn = {
  ["/run/media/dvarkless/WindowsData/LinuxExchange/arduino/GrowLanternLCD"] = "arduino:avr:nano",
}
-- List of servers to install
local servers = { "html", "cssls", "clangd", "pyright"}

require("mason-lspconfig").setup {
  ensure_installed = servers,
}

-- This will setup lsp for servers you listed above
-- And servers you install through mason UI
-- So defining servers in the list above is optional
require("mason-lspconfig").setup_handlers {
  -- Default setup for all servers, unless a custom one is defined below
  function(server_name)
    lspconfig[server_name].setup {
      on_attach = function(client, bufnr)
        on_attach(client, bufnr)
        -- Add your other things here
        -- Example being format on save or something
        client.documentFormattingProvider = true
      end,
      capabilities = capabilities,
    }
  end,
  -- custom setup for a server goes after the function above
  -- Example, override lua_ls
  ["lua_ls"] = function()
    lspconfig["lua_ls"].setup {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = {
              [vim.fn.expand "$VIMRUNTIME/lua"] = true,
              [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
              [vim.fn.stdpath "data" .. "/lazy/extensions/nvchad_types"] = true,
              [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
            },
            maxPreload = 100000,
            preloadFileSize = 10000,
          },
        },
      },
    }
  end,
}

lspconfig.arduino_language_server.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  on_new_config = function(config, root_dir)
    local fqbn = my_arduino_fqbn[root_dir]
    if not fqbn then
      vim.notify(("Could not find which FQBN to use in %q. Defaulting to %q."):format(root_dir, DEFAULT_FQBN))
      fqbn = DEFAULT_FQBN
    end
    config.cmd = {
      "arduino-language-server",
      "-cli-config",
      "/home/dvarkless/.arduino15/arduino-cli.yaml",
      "-fqbn",
      fqbn,
    }
  end,
}
