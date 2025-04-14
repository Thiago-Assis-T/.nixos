{
  inputs,
  lib,
  pkgs,
  ...
}:

{
  import = [
    inputs.nvf.homeManagerModules.default
  ];
  programs.nvf = {
    enable = true;
    # your settings need to go into the settings attribute set
    # most settings are documented in the appendix
    settings = {
      vim = {
        viAlias = true;
        vimAlias = true;
        lsp = {
          enable = true;
        };
        languages = {
          nix.enable = true;
          clang.enable = true;
          python.enable = true;
          markdown.enable = true;

        };
      };
    };
  };
}
