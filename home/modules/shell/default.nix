{ config, lib, ... }:

let
  cfg = config.programs.my-shell;
in

{

  options.programs.my-shell = {
    enable = lib.mkEnableOption (lib.mdDoc "my-shell");
  };
  config = lib.mkIf cfg.enable {
    programs = {
      btop.enable = true;
      fastfetch = {
        enable = true;
        settings = {
          logo = {
            source = "nixos_small";
            padding = {
              right = 1;
            };
          };
          display = {
            binaryPrefix = "si";
            color = "blue";
            separator = "  ";
          };
          modules = [
            {
              type = "datetime";
              key = "Date";
              format = "{1}-{3}-{11}";
            }
            {
              type = "datetime";
              key = "Time";
              format = "{14}:{17}:{20}";
            }
            "break"
            "player"
            "media"
          ];
        };
      };
      bat.enable = true;
      fd.enable = true;
      bash = {
        enable = true;
        enableCompletion = true;
        shellAliases = {
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
