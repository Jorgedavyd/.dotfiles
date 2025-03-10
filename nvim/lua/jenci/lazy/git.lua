return {
    "tpope/vim-fugitive",
    dependencies = {
        "sindrets/diffview.nvim",
    },
    config = function()
        --- Setting up vim-fugitive
        vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
        vim.keymap.set("n", "<leader>p", function()
            vim.cmd.Git('push')
        end)
    end,
}
