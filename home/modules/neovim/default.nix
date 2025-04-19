{
  inputs,
    pkgs,
    ...
}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];
  programs.nixvim = {
    enable = true;
    enableMan = true;
    vimAlias = true;
    viAlias = true;
    withNodeJs = true;
    withPerl = true;
    withPython3 = true;
    withRuby = true;
    wrapRc = true;
    files = {
      "ftplugin/nix.lua" = {
        opts = {
          expandtab = true;
          shiftwidth = 2;
          tabstop = 2;
        };
      };
    };
    opts = {
      expandtab = true;
      shiftwidth = 8;
      tabstop = 8;
    };
    clipboard.register = "unnamedplus";
    performance = {
      byteCompileLua = {
        enable = true;
        initLua = true;
        nvimRuntime = true;
        plugins = true;
      };
      combinePlugins.enable = false;
    };
    colorschemes.catppuccin.enable = true;
    plugins = {
      lualine.enable = true;
      treesitter.enable = true;
      treesitter-context.enable = true;
      treesitter-refactor.enable = true;
      treesitter-textobjects.enable = true;
      lsp = {
        enable = true;
        inlayHints = true;
        servers = {
          nixd = {
            enable = true;
            autostart = true;
          };
        };
      };
      lsp-format.enable = true;
    };
  };
}
