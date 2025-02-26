return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
        'nvim-treesitter/playground'
    },
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "c", "lua", "rust", "bash", "python", "cpp",
                "markdown_inline", "vimdoc", "vim",
                "zig", "toml", "sql", "csv", "cmake",
                "cuda", "json", "make", "dockerfile", "haskell",
                "xml", "java"
            },
            sync_install = false,
            auto_install = true,
            indent = {
                enable = true
            },
            highlight = {
                enable = true,
                -- Compatability with vimtex
                disable = {"latex"},
                -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                -- Set this to `true` if you depend on "syntax" being enabled (like for indentation).
                -- Using this option may slow down your editor, and you may see some duplicate highlights.
                -- Instead of true it can also be a list of languages
                additional_vim_regex_highlighting = false,
            },
        })
    end
}
