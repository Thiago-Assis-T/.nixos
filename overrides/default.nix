{ ... }:
{
  nixpkgs.config.packageOverrides = pkgs: {
    freecad-wayland = (pkgs.freecad-wayland.override { ifcSupport = true; });
  };
}
