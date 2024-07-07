{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.programs.my-nvim;
in
{
  options.programs.my-nvim = {
    enable = lib.mkEnableOption (lib.mdDoc "my-nvim");
  };
  config = lib.mkIf cfg.enable {
    home.packages = [ ];

    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      extraLuaConfig = ''
        vim.g.mapleader = ' '
        vim.g.maplocalleader = ' '
        vim.g.have_nerd_font = true
        vim.opt.relativenumber = true
        vim.opt.cursorline = true
        vim.opt.list = true
        vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
        vim.opt.hlsearch = true
        vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
      '';
      plugins = with pkgs.vimPlugins; [
        (pkgs.vimPlugins.nvim-treesitter.withPlugins(p: [ 
	  p.nix
          p.lua 
        ]))
      ];
    };
  };
}
