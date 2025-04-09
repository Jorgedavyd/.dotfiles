local path = vim.fn.expand("%")

return {
    "nvim-neotest/neotest",
    dependencies = {
        'mfussenegger/nvim-dap',
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-neotest/neotest-python",
        "mrcjkb/rustaceanvim",
        "nvim-neotest/neotest-plenary",
        "marilari88/neotest-vitest",
        "lawrence-laz/neotest-zig",
        "alfaix/neotest-gtest",
        "mrcjkb/neotest-haskell",
        "nvim-treesitter/nvim-treesitter"
    },
    config = function()
        local neotest = require("neotest")
        neotest.setup({
            adapters = {
                require("neotest-vitest"),
                require("neotest-plenary"),
                require("neotest-python")({
                    runner = "pytest",
                    python = "/usr/bin/python3.10",
                }),
                require("rustaceanvim.neotest"),
                require("neotest-zig"),
                require("neotest-gtest"),
                require("neotest-haskell"),
            },
            discovery = {
                filter_dir = function(name, rel_path, root)
                    return name ~= "env"
                end,
            }
        })
    end,
    keys = {
        {
            "<leader>ns", function()
                require("neotest").summary.toggle()
            end
        },
        {
            "<leader>rl", function()
                require("neotest").run.run_last({strategy = 'dap'})
            end
        },
        {
            "<leader>nr", function()
                require("neotest").run.run({strategy = 'dap'})
            end
        },
        {
            "<leader>no", function()
                require("neotest").output.open({
                    enter = true,
                    last_run = true,
                    auto_close = true,
                })
            end
        },
        {
            "<leader>nir", function()
                require("neotest").run.run({
                    path,
                    strategy = 'dap'
                })
            end
        },
    }
}
