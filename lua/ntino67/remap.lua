vim.g.mapleader = " "
vim.keymap.set("n", "<leader>r.", vim.cmd.Ex)

-- Moving visual selections up/down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- Move selection down
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv") -- Move selection up

-- Center cursor after jumps
vim.keymap.set("n", "J", "mzJ`z")       -- Join lines and keep cursor position
vim.keymap.set("n", "<C-d>", "<C-d>zz") -- Half-page down, centered
vim.keymap.set("n", "<C-u>", "<C-u>zz") -- Half-page up, centered
vim.keymap.set("n", "n", "nzzzv")       -- Next search result, centered
vim.keymap.set("n", "N", "Nzzzv")       -- Previous search result, centered

-- Format a paragraph and keep cursor position
vim.keymap.set("n", "=ap", "ma=ap'a")
vim.keymap.set("n", "<leader>zig", "<cmd>LspRestart<cr>")

-- Paste without overwriting register
vim.keymap.set("x", "<leader>p", [["_dP]])

-- System clipboard integration
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]]) -- Yank to system clipboard
vim.keymap.set("n", "<leader>Y", [["+Y]])          -- Yank line to system clipboard

-- Disable Ex mode, tmux integration
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- Quickfix navigation
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Search and replace current word
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
