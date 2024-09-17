{ inputs, pkgs, ... }:
let
  statusnotifier-systray-gtk4 =
    pkgs.callPackage ./packages/statusnotifier-systray-gtk4.nix {
      source = inputs.statusnotifier-systray-gtk4-src;
    };
in {
  nixpkgs.config.packageOverrides = pkgs: {
    #nerdfonts = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
    openldap = pkgs.openldap.overrideAttrs { doCheck = false; };
    redis = pkgs.redis.overrideAttrs { doCheck = false; };
    intel-vaapi-driver =
      pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
    nnn = pkgs.nnn.override {
      withNerdIcons = true;
      withPcre = true;
    };
    slstatus = pkgs.slstatus.override { conf = ./configs/slstatus.h; };
    slstatusLaptop =
      pkgs.slstatus.override { conf = ./configs/slstatusLaptop.h; };
    dwl = (pkgs.dwl.overrideAttrs (finalAttrs: previousAttrs: {
      version = "v0.7";
      src = inputs.dwl-src;
      patches = with inputs; [
        dwl-alwayscenter-patch
        dwl-swallow-patch
        dwl-bar-patch
        dwl-bar-systray-patch
      ];
      buildInputs = previousAttrs.buildInputs ++ [
        pkgs.wlroots_0_18
        pkgs.libdrm
        pkgs.fcft
        pkgs.pixman
        pkgs.gtk4
        pkgs.gtk4-layer-shell
        statusnotifier-systray-gtk4
      ];
      enableParallelBuilding = true;
      passthru.providedSessions = [ "dwl" ];
      postInstall = let
        dwlSession = ''
          [Desktop Entry]
          Name=dwl
          Comment=dwm for Wayland
          Exec=slstatus -s | dwl -s "dwlStart <&-"
          Type=Application
        '';
      in ''
        mkdir -p $out/share/wayland-sessions
        echo "${dwlSession}" > $out/share/wayland-sessions/dwl.desktop
      '';
    })).override { configH = ./configs/dwl.h; };
    dwlLaptop = (pkgs.dwl.overrideAttrs (finalAttrs: previousAttrs: {
      version = "v0.7";
      src = inputs.dwl-src;
      patches = with inputs; [
        dwl-alwayscenter-patch
        dwl-swallow-patch
        dwl-bar-patch
        dwl-bar-systray-patch
      ];
      buildInputs = previousAttrs.buildInputs ++ [
        pkgs.wlroots_0_18
        pkgs.libdrm
        pkgs.fcft
        pkgs.pixman
        pkgs.gtk4
        pkgs.gtk4-layer-shell
        statusnotifier-systray-gtk4
      ];
      enableParallelBuilding = true;
      passthru.providedSessions = [ "dwl" ];
      postInstall = let
        dwlSession = ''
          [Desktop Entry]
          Name=dwl
          Comment=dwm for Wayland
          Exec=slstatus -s | dwl -s "dwlStart <&-"
          Type=Application
        '';
      in ''
        mkdir -p $out/share/wayland-sessions
        echo "${dwlSession}" > $out/share/wayland-sessions/dwl.desktop
      '';
    })).override { configH = ./configs/dwlLaptop.h; };
    haskellPackages = pkgs.haskellPackages.override {
      overrides = hsSelf: hsSuper: {
        crypton = pkgs.haskell.lib.overrideCabal hsSuper.crypton
          (oa: { doCheck = false; });
        crypton-x509-validation =
          pkgs.haskell.lib.overrideCabal hsSuper.crypton-x509-validation
          (oa: { doCheck = false; });
        typist = pkgs.haskell.lib.overrideCabal hsSuper.typist
          (oa: { doCheck = false; });
        cryptonite = pkgs.haskell.lib.overrideCabal hsSuper.cryptonite
          (oa: { doCheck = false; });
        x509-validation = pkgs.haskell.lib.overrideCabal hsSuper.x509-validation
          (oa: { doCheck = false; });
      };
    };
  };
}
