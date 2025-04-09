{ inputs, ... }:
{

  imports = [

    inputs.nixvim.homeManagerModules.nixvim
    ./modules/nixvim
    ./modules/git
    ./modules/shell
  ];

  home = {
    username = "thiago";
    homeDirectory = "/home/thiago";
    stateVersion = "23.11";
    packages = [ ];
  };
}
