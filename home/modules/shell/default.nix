{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.programs.my-shell;
in

{

  options.programs.my-shell = {
    enable = lib.mkEnableOption (lib.mdDoc "my-shell");
  };
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      htop
      bat
      fd
      btop
    ];
    programs = {
      bash = {
        enable = true;
        enableCompletion = true;
        shellAliases = {
          htop = "sudo htop";
          btop = "sudo btop";
          cat = "bat";
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
