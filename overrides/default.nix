{ ... }:
{
  nixpkgs.config.packageOverrides = pkgs: {
    freecad-wayland = (pkgs.freecad-wayland.override { ifcSupport = true; });
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };

  };
}
