-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- 中文技术文档不做拼写检查。
-- LazyVim 默认在 markdown/gitcommit/text 等 buffer 里 `spell = true`，而 polkit、fcitx5、
-- noctalia-shell 这类专有名词必然不在 en 词典里，会满屏红线。本文件在 LazyVim 之后加载，
-- 同名 FileType autocmd 后注册后触发，因此这里的 `spell = false` 生效；wrap 等其它设置保持不变。
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "gitcommit" },
  callback = function()
    vim.opt_local.spell = false
  end,
})
