{ inputs, patches, ... }: {
  nixpkgs.config.packageOverrides = pkgs: {
    dwl = (pkgs.dwl.overrideAttrs {
      version = "v0.6";
      src = inputs.dwl-src;
      inherit patches;
    }).override { conf = ./config.h; };
  };
}
