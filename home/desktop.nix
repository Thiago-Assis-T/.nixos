{ inputs, pkgs, ... }:
{

  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./modules/nvim
    ./modules/shell
    ./modules/git
  ];

  programs.personal-nvim.enable = true;
  programs.base-shell.enable = true;
  programs.my-git.enable = true;

  home = {
    username = "thiago";
    homeDirectory = "/home/thiago";
    stateVersion = "23.11";
    packages = with pkgs; [
      deluge-gtk
      floorp
    ];
  };
}
