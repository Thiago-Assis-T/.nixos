{ config, lib, ... }:

{
    #home.sessionVariables = { TERM = "kitty"; };
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
        shellAliases = { cat = "bat"; };
        bashrcExtra = builtins.readFile ./bashrcExtra.sh;
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
}
