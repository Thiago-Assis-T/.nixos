require("nvim-treesitter.configs").setup({
	highlight = {
		enable = true,
	},
})

require("neorg").setup({
	load = {
		["core.defaults"] = {},
	},
})
