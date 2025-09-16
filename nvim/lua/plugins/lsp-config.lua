return {
    "neovim/nvim-lspconfig",
    dependencies = {
        { "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        {
            "j-hui/fidget.nvim",
            opts = {
                progress = {
                    poll_rate = 5,
                    suppress_on_insert = true, -- Suppress new messages while in insert mode
                    ignore_done_already = true, -- Ignore new tasks that are already complete
                    ignore_empty_message = false, -- Ignore new tasks that don't contain a message
                },
                notification = {
                    override_vim_notify = true,
                },
            },
        },
        { "folke/lazydev.nvim", config = true }, -- Lua LSP for Neovim config
    },
    config = function()
        require("mason").setup()

        require("mason-lspconfig").setup({
            automatic_installation = true,
            ensure_installed = {
                "lua_ls",
                "ty",
                "clangd"
            },
            handlers = {
                function(server_name)
                    vim.lsp.enable(server_name)
                end,
            },
        })

        vim.lsp.config("lua_ls", {
            settings = {
                Lua = {
                    format = {
                        enable = false,
                    },
                },
            },
        })

        vim.lsp.config("basedpyright", {
            settings = {
                basedpyright = {
                    analysis = {
                        diagnosticMode = "openFilesOnly",
                        typeCheckingMode = "standard",
                        -- stubPath = vim.fn.expand("$HOME/.local/share/stubs"),
                        inlayHints = {
                            callArgumentNames = true,
                        },
                    },
                },
            },
        })

        vim.lsp.config("jedi_language_server", {
            init_options = {
                codeAction = {
                    nameExtractVariable = "Extract variable",
                    nameExtractFunction = "Extract function",
                },
                markupKindPreferred = "markdown",
            },
        })

        vim.lsp.config("texlab", {
            filetypes = { "markdown", "tex" },
            settings = {
                texlab = {
                    build = {
                        executable = "latexrun",
                    },
                },
            },
        })

        vim.lsp.config("ltex", {
            filetypes = { "markdown", "tex" },
            settings = {
                ltex = {
                    language = "en-GB",
                    disabledRules = {
                        ["en-GB"] = { "OXFORD_SPELLING_Z_NOT_S" },
                    },
                },
            },
        })

        vim.lsp.config("tinymist", {
            settings = {
                exportPdf = "onSave",
                formatterMode = "typstyle",
                rootPath = vim.fn.expand("$HOME"),
            },
        })

    end,

    init = function()
        vim.api.nvim_create_autocmd("LspDetach", {
            group = vim.api.nvim_create_augroup(
                "kickstart-lsp-detach",
                { clear = true }
            ),
            callback = function()
                vim.lsp.buf.clear_references()
            end,
        })
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup(
                "kickstart-lsp-attach",
                { clear = true }
            ),
            callback = function(event)
                local map = function(keys, func, desc)
                    vim.keymap.set(
                        "n",
                        keys,
                        func,
                        { buffer = event.buf, desc = "LSP: " .. desc }
                    )
                end

                map("gd", vim.lsp.buf.definition, "Goto Definition")
                map("gD", vim.lsp.buf.declaration, "Goto Declaration")
            end,
        })
    end,
}
