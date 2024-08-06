{ config, lib, ... }:

let cfg = config.programs.my-shell;

in {
  options.programs.my-shell = {
    enable = lib.mkEnableOption (lib.mdDoc "my-shell");
  };
  config = lib.mkIf cfg.enable {
    programs = {
      btop.enable = true;
      fastfetch = {
        enable = true;
        settings = { };
      };
      bat.enable = true;
      fd.enable = true;
      bash = {
        enable = true;
        enableCompletion = true;
        shellAliases = {
          cat = "bat";
          ls = "nnn -eH";
          nnn = "nnn -e";
        };
      };
      starship = {
        enable = true;
        enableBashIntegration = true;
      };
      nix-index = {
        enable = true;
        enableBashIntegration = true;
      };
      fzf = {
        enable = true;
        enableBashIntegration = true;
      };
    };
  };
}
