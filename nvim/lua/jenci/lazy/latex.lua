return {
    'lervag/vimtex',
    config = function()
        vim.g.vimtex_view_general_viewer = 'zathura'
        vim.g.vimtex_compiler_method = 'latexmk'
        vim.g.vimtex_view_method = 'general'
        vim.keymap.set('n', '<leader>ll', ':VimtexCompile<CR>', { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>lv', ':VimtexView<CR>', { noremap = true, silent = true })
    end
}
