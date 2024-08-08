require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		nix = { "nixfmt" },
		c = { "clang-format" },
	},
	notify_on_error = false,
	format_on_save = {
		lsp_format = "fallback",
		timeout_ms = 500,
	},
})
