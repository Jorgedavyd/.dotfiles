return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function ()
        require('lualine').setup({
            options = {
                theme = 'auto',
                component_separators = { left = '|', right = '|' },
                section_separators = { left = '', right = '' },
                disabled_filetypes = { 'packer', 'NVimTree' }
            }
        })
        vim.opt.laststatus = 1
    end,
}


