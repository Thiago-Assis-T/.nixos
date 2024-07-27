{ inputs, ... }: {
  nixpkgs.overlays = [
    inputs.neorg-overlay.overlays.default

  ];
  nixpkgs.config.packageOverrides = pkgs: {
    intel-vaapi-driver =
      pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
  };
}
