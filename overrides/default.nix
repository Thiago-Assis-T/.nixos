{ ... }:
{
  nixpkgs.config.packageOverrides = pkgs: {
    freecad = (pkgs.freecad-wayland.override { ifcSupport = true; });
  };
}
