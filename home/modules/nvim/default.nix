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
				nixfmt-classic
				stylua
			];
			extraLuaConfig = ''
				vim.g.mapleader = ' '
				vim.g.maplocalleader = ' '
				vim.opt.termguicolors = true
				vim.g.have_nerd_font = true
				vim.opt.relativenumber = true
				vim.opt.cursorline = true
				vim.opt.hlsearch = true
				vim.opt.tabstop = 4
				vim.opt.shiftwidth = 4
				vim.opt.updatetime = 300
				vim.opt.scrolloff = 10
				vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
				vim.keymap.set('n', ']d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
				vim.keymap.set('n', '[d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
				vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
				vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
				'';
			plugins =  [
				pkgs.vimPlugins.plenary-nvim
				{
					plugin = pkgs.vimPlugins.nvim-treesitter.withAllGrammars;
					type = "lua";
					config = builtins.readFile ./lua/treesitter.lua;
				}

				{
					plugin = pkgs.vimPlugins.gitsigns-nvim;
					type = "lua";
					config = '' require("gitsigns").setup() '';
				}

				{
					plugin = pkgs.vimPlugins.nvim-lspconfig;
					type = "lua";
					config = builtins.readFile ./lua/lsp.lua;
				}
				
				{
					plugin = pkgs.vimPlugins.nvim-web-devicons;
					type = "lua";
					config = '' require'nvim-web-devicons'.setup {} '';
				}
				
				{
					plugin = pkgs.vimPlugins.nvim-web-devicons;
					type = "lua";
					config = '' require'nvim-web-devicons'.setup {} '';
				}

				{
					plugin = pkgs.vimPlugins.lualine-nvim;
					type = "lua";
					config = builtins.readFile ./lua/lualine.lua;
				}
				{
					plugin = pkgs.vimPlugins.conform-nvim;
					type = "lua";
					config = builtins.readFile ./lua/conform.lua;
				}
			];
		};
	};
}
