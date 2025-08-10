--------------------------------
-- Keymaps
--------------------------------
local opts = { noremap = true, silent = true }

-- Diagnostic
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "dP", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "dN", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)
vim.keymap.set("n", "<leader>cd", ":cd %:p:h<CR>:pwd<CR>", opts)

-- FZF Telescope
vim.keymap.set("n", "<leader>fo", ":FzfLua oldfiles<CR>", opts)
vim.keymap.set("n", "<leader>ff", ":FzfLua files<CR>", opts)
vim.keymap.set("n", "<leader>f", ":FzfLua<CR>", opts)

-- Buffer navigation
vim.keymap.set("n", "<Leader>bn", ":bnext <CR>", opts)
vim.keymap.set("n", "<Leader>bp", ":bprevious <CR>", opts)
vim.keymap.set("n", "<Leader>bd", ":bdelete <CR>", opts)

-- Trouble
vim.keymap.set("n", "<Leader>er", ":TroubleToggle <CR>", opts)
vim.keymap.set("n", "<leader>xx", function() require("trouble").open() end, opts)
vim.keymap.set("n", "<leader>xw", function() require("trouble").open("workspace_diagnostics") end, opts)
vim.keymap.set("n", "<leader>xd", function() require("trouble").open("document_diagnostics") end, opts)
vim.keymap.set("n", "<leader>xq", function() require("trouble").open("quickfix") end, opts)
vim.keymap.set("n", "<leader>xl", function() require("trouble").open("loclist") end, opts)
vim.keymap.set("n", "gR", function() require("trouble").open("lsp_references") end, opts)
