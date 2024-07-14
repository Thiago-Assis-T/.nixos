{ config, pkgs, lib, ... }:
let
	cfg = config.programs.my-nvim;
in
{
	options.programs.my-nvim = {
		enable = lib.mkEnableOption (lib.mdDoc "my-nvim");
	};
	config = lib.mkIf cfg.enable {

		programs.neovim = {
			enable = true;
			defaultEditor = true;
			viAlias = true;
			vimAlias = true;
			vimdiffAlias = true;
			withNodeJs = true;
			withPython3 = true;
			extraPackages = with pkgs; [
				nixd
				lua-language-server
			];
			extraLuaConfig = ''
				vim.g.mapleader = ' '
				vim.g.maplocalleader = ' '
				vim.opt.termguicolors = true
				vim.g.have_nerd_font = true
				vim.opt.relativenumber = true
				vim.opt.cursorline = true
				vim.opt.list = false
				vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
				vim.opt.hlsearch = true
				vim.opt.tabstop = 4
				vim.opt.shiftwidth = 4
				vim.opt.updatetime = 300
				vim.opt.scrolloff = 10
				vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
				vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
				vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
				vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
				vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
				'';
			plugins = with pkgs.vimPlugins; [
				nvim-treesitter.withAllGrammars
				{
					plugin = gitsigns-nvim;
					type = "lua";
					config = '' require("gitsigns").setup() '';
				}
				{
					plugin = nvim-lspconfig;
					type = "lua";
					config = builtins.readFile ./lua/lsp.lua;
				}
			];
		};
	};
}
