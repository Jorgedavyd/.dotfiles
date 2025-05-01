return {
    "neovim/nvim-lspconfig",
    dependencies = {
        {
            "mfussenegger/nvim-jdtls",
            ft = 'java',
        },
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
        local cmp_lsp = require("cmp_nvim_lsp")

        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities()
        )

        require("mason").setup()

        require("mason-tool-installer").setup({
            ensure_installed = {
                'java-debug-adapter',
                'java-test',
            }
        })

        require("mason-lspconfig").setup({
            automatic_installation = true,
            ensure_installed = {
                "lua_ls",
                "rust_analyzer",
                "clangd",
                "cmake",
                "sqlls",
                "pyright",
                "zls",
                "ltex",
                "dockerls",
                "docker_compose_language_service",
                "jdtls",
                "yamlls",
                "gopls",
                "regols"
            },

            handlers = {
                function(server_name)
                    if server_name ~= 'jdtls' and server_name ~= 'rust_analyzer' then
                        require("lspconfig")[server_name].setup {
                            capabilities = capabilities
                        }
                    end
                end,

                lua_ls = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
                                }
                            }
                        }
                    }
                end,

                zls = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.zls.setup({
                        capabilities = capabilities,
                        root_dir = lspconfig.util.root_pattern(".git", "build.zig", "zls.json"),
                        settings = {
                            zls = {
                                enable_inlay_hints = true,
                                enable_snippets = true,
                                warn_style = true,
                            },
                        },
                    })
                    vim.g.zig_fmt_parse_errors = 0
                    vim.g.zig_fmt_autosave = 0
                end,

                clangd = function()
                    local lspconfig = require('lspconfig')
                    lspconfig.clangd.setup {
                        capabilities = capabilities,
                        filetypes = { "c", "cpp", "cuda", "cu", "h"},
                        cmd = {
                            "clangd",
                            "--header-insertion=never",
                            "--clang-tidy",
                            "--compile-commands-dir=build",
                        },
                        root_dir = lspconfig.util.root_pattern(".git", "compile_commands.json", "compile_flags.txt", "CMakeLists.txt"),
                        settings = {
                            clangd = {
                                fallbackFlags = {
                                    "--std=c++20",
                                    "--cuda-path=/opt/cuda",
                                    "--cuda-gpu-arch=sm_89",
                                    "-L/opt/cuda/lib",
                                    "-I/opt/cuda/include",
                                },
                            },
                        },
                    }
                end,

                pyright = function ()
                    local lspconfig = require("lspconfig")
                    lspconfig.pyright.setup({
                        capabilities = capabilities,
                        settings = {
                            python = {
                                analysis = {
                                    typeCheckingMode = "basic",
                                    autoSearchPaths = true,
                                    useLibraryCodeForTypes = true
                                }
                            }
                        }
                    })
                end,

                yamlls = function ()
                    local lspconfig = require("lspconfig")
                    lspconfig.yamlls.setup({
                        settings = {
                            yaml = {
                                schemas = {
                                    ["kubernetes"] = "*.yaml",  -- Kubernetes manifests
                                    ["https://raw.githubusercontent.com/SchemaStore/schemastore/refs/heads/master/src/schemas/json/github-workflow.json"] = ".github/workflows/*",  -- GitHub Workflows
                                    ["https://raw.githubusercontent.com/SchemaStore/schemastore/refs/heads/master/src/schemas/json/github-action.json"] = ".github/action.{yml,yaml}",  -- GitHub Actions
                                    ["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",  -- Helm Charts
                                    ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*docker-compose*.{yml,yaml}",  -- Docker Compose
                                    ["https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json"] = "*flow*.{yml,yaml}",  -- Argo Workflows
                                },
                                validate = true,
                                hover = true,
                                completion = true
                            }
                        }
                    })
                end
            }
        })

    end
}
