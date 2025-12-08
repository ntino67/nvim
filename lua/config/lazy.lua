-- Variables
local o = vim.opt
local api = vim.api

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- This is also a good place to setup other settings (vim.opt)

o.number = true -- Print the line number in front of each line
o.relativenumber = true -- Show the line number relative to the line with the cursor in front of each line.
o.syntax = "on" -- When this option is set, the syntax with this name is loaded.
o.autoindent = true -- Copy indent from current line when starting a new line.
o.cursorline = true -- Highlight the screen line of the cursor with CursorLine.
o.expandtab = true -- In Insert mode: Use the appropriate number of spaces to insert a <Tab>.
o.shiftwidth = 2 -- Number of spaces to use for each step of (auto)indent.
o.tabstop = 2 -- Number of spaces that a <Tab> in the file counts for.
o.encoding = "UTF-8" -- Sets the character encoding used inside Vim.
o.ruler = true -- Show the line and column number of the cursor position, separated by a comma.
o.mouse = "a" -- Enable the use of the mouse. "a" you can use on all modes
o.title = true -- When on, the title of the window will be set to the value of 'titlestring'
o.hidden = true -- When on a buffer becomes hidden when it is |abandon|ed
o.ttimeoutlen = 0 -- The time in milliseconds that is waited for a key code or mapped key sequence to complete.
o.wildmenu = true -- When 'wildmenu' is on, command-line completion operates in an enhanced mode.
o.showcmd = true -- Show (partial) command in the last line of the screen. Set this option off if your terminal is slow.
o.showmatch = true -- When a bracket is inserted, briefly jump to the matching one.
o.inccommand = "split" -- When nonempty, shows the effects of :substitute, :smagic, :snomagic and user commands with the :command-preview flag as you type.
o.splitright = true
o.splitbelow = true -- When on, splitting a window will put the new window below the current one
o.termguicolors = true

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

-- Setup lazy.nvim
require("lazy").setup("plugins")
