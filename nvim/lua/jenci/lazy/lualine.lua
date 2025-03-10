return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function ()
        local custom = require("lualine.themes.auto")
        custom.normal.c.bg = "#0d1011"
        custom.normal.b.bg = "#1B2023"
        require('lualine').setup({
            options = {
                theme = custom,
                component_separators = { left = '|', right = '|' },
                section_separators = { left = '', right = '' },
                disabled_filetypes = { 'packer', 'NVimTree' }
            }
        })
        vim.opt.laststatus = 1
    end,
}


