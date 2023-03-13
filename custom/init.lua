local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })

vim.opt.showmatch = true              -- show matching
vim.opt.ignorecase = true             -- case insensitive
vim.opt.tabstop = 4                   -- number of columns occupied by a tab
vim.opt.softtabstop = 4               -- see multiple spaces as tabstops so <BS> does the right thing
vim.opt.expandtab = true              -- converts tabs to white space
vim.opt.shiftwidth = 4                -- width for autoindents
vim.opt.autoindent = true             -- indent a new line the same amount as the line just typed
vim.opt.smartindent = true
vim.opt.relativenumber = true         -- add line numbers
vim.opt.iskeyword:append("_")
vim.opt.encoding = 'utf-8'
vim.opt.winminwidth = 5 -- minimum window width
vim.opt.backup = true
vim.opt.wildignore = [[
.git,.hg,.svn
*.aux,*.out,*.toc
*.o,*.obj,*.exe,*.dll,*.manifest,*.rbc,*.class
*.ai,*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png,*.psd,*.webp
*.avi,*.divx,*.mp4,*.webm,*.mov,*.m2ts,*.mkv,*.vob,*.mpg,*.mpeg
*.mp3,*.oga,*.ogg,*.wav,*.flac
*.eot,*.otf,*.ttf,*.woff
*.doc,*.pdf,*.cbr,*.cbz
*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz,*.kgb
*.swp,.lock,.DS_Store,._*
*/tmp/*,*.so,*.swp,*.zip,**/node_modules/**,**/target/**,**.terraform/**"
]]

local enable_providers = {
      "python3_provider",
      "node_provider",
      -- and so on
    }
    
    for _, plugin in pairs(enable_providers) do
      vim.g["loaded_" .. plugin] = nil
      vim.cmd("runtime " .. plugin)
    end

vim.g.python3_host_prog = '~/.venvs/nvim_venv/bin/python'
vim.g.loaded_python3_provider = 1


if vim.g.neovide then
    -- Put anything you want to happen only in Neovide here

    vim.o.guifont = "Source Code Pro:h12" -- text below applies for VimScript
    vim.g.neovide_scale_factor = 1.0
    vim.g.neovide_transparency = 0.4
    vim.g.neovide_hide_mouse_when_typing = true
    vim.g.neovide_cursor_vfx_mode = "railgun"
end
