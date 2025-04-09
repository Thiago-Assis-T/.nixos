{ ... }:
{
  nixpkgs.config.packageOverrides = pkgs: {
    freecad-wayland = (pkgs.freecad-wayland.override { ifcSupport = true; });
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
    heroic = pkgs.heroic.override {
      extraPkgs = pkgs: [
        pkgs.gamescope
        pkgs.gamemode
      ];
      extraLibraries = pkgs: [

      ];
    };

    lutris = pkgs.lutris.override {
      extraPkgs = pkgs: [
        pkgs.gamescope
        pkgs.gamemode
      ];
      extraLibraries = pkgs: [

      ];
    };

  };
}
