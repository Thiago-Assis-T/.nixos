{ ... }: {

  imports = [ 
    ./modules/nvim
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
