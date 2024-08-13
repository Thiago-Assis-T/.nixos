{ config, pkgs, lib, ... }:
let cfg = config.programs.my-nvim;
in {
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
        bash-language-server
        shellcheck
        beautysh

        clang
        clang-tools

        fd
        ripgrep

        nixd
        nixfmt-classic

        lua-language-server
        stylua
        #luajitPackages.luacheck
      ];
      extraLuaConfig = builtins.readFile ./lua/extraConfig.lua;
      plugins = [
        pkgs.vimPlugins.plenary-nvim
        pkgs.vimPlugins.neorg-telescope
        {
          plugin = pkgs.vimPlugins.neorg;
          type = "lua";
          config = builtins.readFile ./lua/neorg.lua;
        }
        {
          plugin = pkgs.vimPlugins.nvim-treesitter.withAllGrammars;
          type = "lua";
          config = builtins.readFile ./lua/treesitter.lua;
        }
        {
          plugin = pkgs.vimPlugins.gitsigns-nvim;
          type = "lua";
          config = ''require("gitsigns").setup() '';
        }
        pkgs.vimPlugins.luasnip
        pkgs.vimPlugins.friendly-snippets
        pkgs.vimPlugins.cmp-nvim-lsp
        {
          plugin = pkgs.vimPlugins.nvim-cmp;
          type = "lua";
          config = builtins.readFile ./lua/cmp.lua;

        }
        {
          plugin = pkgs.vimPlugins.nvim-lspconfig;
          type = "lua";
          config = builtins.readFile ./lua/lsp.lua;
        }
        {
          plugin = pkgs.vimPlugins.nvim-web-devicons;
          type = "lua";
          config = "require'nvim-web-devicons'.setup {} ";
        }
        {
          plugin = pkgs.vimPlugins.nvim-web-devicons;
          type = "lua";
          config = "require'nvim-web-devicons'.setup {} ";
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
        {
          plugin = pkgs.vimPlugins.nvim-lint;
          type = "lua";
          config = builtins.readFile ./lua/lint.lua;
        }

        pkgs.vimPlugins.telescope-file-browser-nvim
        pkgs.vimPlugins.telescope-fzf-native-nvim
        {
          plugin = pkgs.vimPlugins.telescope-nvim;
          type = "lua";
          config = builtins.readFile ./lua/telescope.lua;
        }
      ];
    };
  };
}
