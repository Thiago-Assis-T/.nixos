vim.g.mapleader = " "
vim.opt.clipboard = "unnamedplus"
vim.g.maplocalleader = " "
vim.opt.termguicolors = true
vim.g.have_nerd_font = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.hlsearch = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.updatetime = 300
vim.opt.scrolloff = 10

vim.cmd("colorscheme onedark")

vim.api.nvim_set_hl(0, "Normal", { bg = "none", ctermbg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none", ctermbg = "none" })
vim.api.nvim_set_hl(0, "WinSeparator", { bg = "none", ctermbg = "none" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "none", ctermbg = "none" })

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
