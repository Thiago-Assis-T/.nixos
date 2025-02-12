{ pkgs, ... }:
{

  imports = [ ./modules ];

  home = {
    username = "thiago";
    homeDirectory = "/home/thiago";
    stateVersion = "23.11";
    packages = [
    ];

  };
}
