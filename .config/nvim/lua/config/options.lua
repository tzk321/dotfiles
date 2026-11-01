-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- "cjk" makes spell skip words containing CJK characters (Chinese/Japanese/Korean),
-- so Chinese text itself is not flagged. It does NOT whitelist English proper nouns
-- (polkit / fcitx5 / noctalia-shell ...), which is why markdown buffers disable spell
-- entirely in lua/config/autocmds.lua. Kept for when spell is toggled on manually.
vim.opt.spelllang = { "en", "cjk" }
