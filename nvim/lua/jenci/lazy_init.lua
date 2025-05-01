local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = {
        { import = "jenci.lazy" },
        { import = "jenci.lazy.completion" },
        { import = "jenci.lazy.lsp" },
        { import = "jenci.lazy.motion" },
        { import = "jenci.lazy.testing" },
        { import = "jenci.lazy.ui" },
        { import = "jenci.lazy.ui.themes" },
    },
    change_detection = { notify = false }
})
