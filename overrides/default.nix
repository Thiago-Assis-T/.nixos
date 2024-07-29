{ inputs, ... }: {
  nixpkgs.config.packageOverrides = pkgs: {
    intel-vaapi-driver =
      pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
    nnn = pkgs.nnn.override {
      withNerdIcons = true;
      withPcre = true;
    };
    dwl = pkgs.dwl.overrideAttrs {
      version = "0.6";
      #patches = inputs.dwl-barPatch;
    };
  };
}
