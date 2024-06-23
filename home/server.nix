{ inputs, ... }:
{

  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./modules
  ];

  programs.my-nvim.enable = true;
  programs.my-shell.enable = true;
  programs.my-git.enable = true;

  home = {
    username = "thiago";
    homeDirectory = "/home/thiago";
    stateVersion = "23.11";
    packages = [ ];
  };
}
