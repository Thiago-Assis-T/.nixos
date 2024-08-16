require("nvim-treesitter.configs").setup({
	highlight = {
		enable = true,
	},
})

require("neorg").setup({
	load = {
		["core.defaults"] = {},
		["core.integrations.telescope"] = {
			config = {
				insert_file_link = {
					show_title_preview = true,
				},
			},
		},
	},
})

vim.keymap.set("n", "<leader>nf", "<Plug>(neorg.telescope.find_norg_files)", { desc = "[N]eorg [F]iles" })
vim.keymap.set("n", "<leader>nh", "<Plug>(neorg.telescope.search_headings)", { desc = "[N]eorg [H]eadings" })
