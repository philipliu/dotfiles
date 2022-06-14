local M = {}
local keymap = vim.keymap

function M.setup()
    -- Mappings.
    -- See `:help vim.diagnostic.*` for documentation on any of the below functions
    local opts = { noremap = true, silent = true }
    vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

    keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
    keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.implementation()<CR>")
    keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
    keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
    keymap.set("n", "ga", "<cmd>lua vim.lsp.buf.code_action()<CR>")

    -- Use a loop to conveniently call 'setup' on multiple servers and
    -- map buffer local keybindings when the language server attaches
    local servers = { 'rust_analyzer', 'tsserver' }
    for _, lsp in pairs(servers) do
        require('lspconfig')[lsp].setup {
            on_attach = on_attach,
            flags = {
                -- This will be the default in neovim 0.7+
                debounce_text_changes = 150,
            }
        }
    end

    -- setup icons in gutter
    local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
    for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end

    -- format on save
    vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.formatting_sync()]]
end

function M.setup_rust()
    local opts = {
        tools = { -- rust-tools options
            autoSetHints = true,
            hover_with_actions = true,
            inlay_hints = {
                show_parameter_hints = true,
                parameter_hints_prefix = "‣",
                other_hints_prefix = "‣",
            },
        },

        -- all the opts to send to nvim-lspconfig
        -- these override the defaults set by rust-tools.nvim
        -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
        server = {
            -- on_attach is a callback called when the language server attachs to the buffer
            -- on_attach = on_attach,
            settings = {
                -- to enable rust-analyzer settings visit:
                -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
                ["rust-analyzer"] = {
                    -- enable clippy on save
                    checkOnSave = {
                        command = "clippy"
                    },
                }
            }
        },
    }

    require('rust-tools').setup(opts)
end

return M
