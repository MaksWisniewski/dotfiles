return { -- Fuzzy Finder (files, lsp, etc)
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    lazy = true,
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
            cond = function()
                return vim.fn.executable("make") == 1
            end,
        },
        "nvim-telescope/telescope-ui-select.nvim",
        "nvim-tree/nvim-web-devicons",
    },
    init = function()
        local builtin = require("telescope.builtin")

        -- File pickers
        vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope Files" })
        vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope Live Grep" })
        vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope Buffers" })
        vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope Help Tags" })

        -- Diagnostics
        vim.keymap.set("n", "<leader>fx", builtin.diagnostics, { desc = "Telescope Diagnostics (Document)" })
        vim.keymap.set("n", "<leader>fX", function()
            builtin.diagnostics({ severity = nil }) -- workspace-level
        end, { desc = "Telescope Diagnostics (Workspace)" })

        -- Symbols
        vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, { desc = "Telescope Document Symbols" })
        vim.keymap.set("n", "<leader>fS", builtin.lsp_workspace_symbols, { desc = "Telescope Workspace Symbols" })
    end,
    config = function()
        local actions = require("telescope.actions")
        local action_state = require("telescope.actions.state")

        local entry_append = function(prompt_bufnr)
            local entry = action_state.get_selected_entry()[1]
            actions.close(prompt_bufnr)
            vim.api.nvim_put({ entry }, "c", false, true)
        end

        require("telescope").setup({
            defaults = {
                border = false,
                layout_config = { vertical = { width = 0.5 } },
                mappings = {
                    i = {
                        ["<esc>"] = actions.close,
                        ["<C-i>"] = entry_append,
                    },
                },
            },
            pickers = {
                find_files = { theme = "dropdown" },
                live_grep = { theme = "dropdown" },
                buffers = { theme = "dropdown" },
                help_tags = { theme = "dropdown" },
                diagnostics = { theme = "dropdown" },
                lsp_document_symbols = { theme = "dropdown" },
                lsp_workspace_symbols = { theme = "dropdown" },
            },
        })

        -- Load extensions (fzf-native for speed)
        pcall(require("telescope").load_extension, "fzf")
        pcall(require("telescope").load_extension, "ui-select")
    end,
}

