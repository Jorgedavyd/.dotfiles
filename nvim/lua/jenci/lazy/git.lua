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
        --- Setting up diffview
        vim.keymap.set("n", "<leader>gd", function()
            local lib = require('diffview.lib')
            local view = lib.get_current_view()
            if view then
                vim.cmd("DiffviewClose")
            else
                vim.cmd("DiffviewOpen")
            end
        end)
        vim.keymap.set("n", "]g", "<cmd>silent! /^<<<<<<< \\|^=======\\|^>>>>>>><CR>", { silent = true })
        vim.keymap.set("n", "[g", "<cmd>silent! ?^<<<<<<< \\|^=======\\|^>>>>>>><CR>", { silent = true })
        vim.keymap.set("n", "<leader>gb", ":Git blame<CR>")
        vim.keymap.set("n", "<leader>gl", ":0Gclog<CR>")

        vim.keymap.set("n", "<leader>gn", function()
            local found = vim.fn.search('^<<<<<<< \\|^=======\\|^>>>>>>>', 'W')
            if found > 0 then
                local line = vim.fn.getline('.')
                if string.match(line, '^<<<<<<< ') then
                    vim.cmd('normal! jdd/^=======\\|^>>>>>>>\nd/^>>>>>>>\nd')
                elseif string.match(line, '^=======') then
                    vim.cmd('normal! dd/^>>>>>>>\nd')
                end
                return
            end
        end)
    end,
}
