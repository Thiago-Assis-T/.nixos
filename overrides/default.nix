{ inputs, ... }: {
  nixpkgs.config.packageOverrides = pkgs: {
    intel-vaapi-driver =
      pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
    nnn = pkgs.nnn.override {
      withNerdIcons = true;
      withPcre = true;
    };
    dwl = (pkgs.dwl.overrideAttrs {
      version = "v0.6";
      src = inputs.dwl-src;
    }).override {
      conf = ../hosts/modules/dwl/config.h;

    };
  };
}
