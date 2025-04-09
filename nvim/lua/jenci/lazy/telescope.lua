return {
    "nvim-telescope/telescope.nvim",

    dependencies = {
        "nvim-lua/plenary.nvim"
    },

    config = function()
        require('telescope').setup({
            defaults = {
                sorting_strategy = "ascending",
                layout_strategy = "horizontal",
                layout_config = {
                    prompt_position = "top",
                    preview_cutoff = 120,
                },
                mappings = {
                    i = {
                        ["<C-j>"] = "move_selection_next",
                        ["<C-k>"] = "move_selection_previous",
                    },
                },
            },
            pickers = {
                colorscheme = {
                    enable_preview = true,
                    ignore_builtins = true
                }
            }
        })

        local builtin = require('telescope.builtin')
        local map = vim.keymap.set

        map('n', '<leader>pf', builtin.find_files, {})
        map('n', '<C-p>', builtin.git_files, {})
        map('n', '<leader>w', builtin.colorscheme, {})
        map('n', '<leader>pws', function()
            builtin.grep_string({ search = vim.fn.expand("<cword>") })
        end)
        map('n', '<leader>pWs', function()
            builtin.grep_string({ search = vim.fn.expand("<cWORD>") })
        end)
        map('n', '<leader>ps', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end)
        map('n', '<leader>vh', builtin.help_tags, {})
    end
}

