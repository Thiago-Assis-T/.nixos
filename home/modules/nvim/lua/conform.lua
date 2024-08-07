require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		--nix = { "nixfmt" },
	},
	notify_on_error = false,
	format_on_save = {
		-- I recommend these options. See :help conform.format for details.
		lsp_format = "fallback",
		timeout_ms = 500,
	},
})
