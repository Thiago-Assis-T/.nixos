require("lint").linters_by_ft = {
	nix = { "nix" },
	lua = { "luacheck" },
	c = { "clangtidy" },
	bash = { "shellcheck" },
	python = { "pylint" },
	latex = { "chktex" },
}
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		require("lint").try_lint()
	end,
})
