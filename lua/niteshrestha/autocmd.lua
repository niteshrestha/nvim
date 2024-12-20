local augroup = vim.api.nvim_create_augroup
local NiteshAutoGroup = augroup('NiteshAutoGroup', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 100,
        })
    end,
})

--autocmd('LspAttach', {
--    group = NiteshAutoGroup,
--    callback = function(e)
--        local opts = { buffer = e.buf }
--        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
--        vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
--        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
--        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
--        vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
--        vim.keymap.set("n", "<leader>.", function() vim.lsp.buf.code_action() end, opts)
--        vim.keymap.set("n", "<leader>r", function() vim.lsp.buf.rename() end, opts)
--        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
--        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
--        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
--    end
--})

autocmd("FileType", {
    group = NiteshAutoGroup,
    pattern = "cs",
    command = "compiler dotnet",
})

autocmd("FileType", {
    group = NiteshAutoGroup,
    pattern = { "text", "tex", "markdown", "gitcommit" },
    command = "setlocal spell",
})
