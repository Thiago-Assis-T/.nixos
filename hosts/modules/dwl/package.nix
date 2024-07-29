{ inputs, patches, ... }: {
  nixpkgs.config.packageOverrides = pkgs: {
    dwl = (pkgs.dwl.overrideAttrs {
      version = "v0.6";
      src = inputs.dwl-src;
      patches = [ ./patches/bar.patch ];
    }).override {
      #conf = ./config.h;
    };
  };
}
