{
  config,
  pkgs,
  lib,
  ...
}:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    withPython3 = true;
    extraPackages = with pkgs; [
      python312Packages.python-lsp-server
      pylint
      yapf

      bash-language-server
      shellcheck
      beautysh

      clang
      clang-tools

      fd
      ripgrep

      nixd
      nixfmt-rfc-style

      lua-language-server
      stylua
      luajitPackages.luacheck

      texliveFull
      ltex-ls
      texlab
      xdotool
      pstree

    ];
    extraLuaConfig = builtins.readFile ./lua/extraConfig.lua;
    plugins = [
      #pkgs.vimPlugins.nvim-dap-ui
      #pkgs.vimPlugins.nvim-dap-virtual-text
      #pkgs.vimPlugins.nvim-nio
      #pkgs.vimPlugins.nvim-dap-python
      #{
      #plugin = pkgs.vimPlugins.nvim-dap;
      #type = "lua";
      #config = builtins.readFile ./lua/debugger.lua;
      #}

      pkgs.vimPlugins.onedarkpro-nvim
      pkgs.vimPlugins.plenary-nvim
      {
        plugin = pkgs.vimPlugins.vimtex;
        type = "lua";
        config = builtins.readFile ./lua/vimtex.lua;

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
      pkgs.vimPlugins.cmp_luasnip
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
}
