{ inputs, ... }: {
  nixpkgs.config.packageOverrides = pkgs: {
    intel-vaapi-driver =
      pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
    nnn = pkgs.nnn.override {
      withNerdIcons = true;
      withPcre = true;
    };
    slstatus = pkgs.slstatus.override { conf = ./configs/slstatus.h; };
    dwl = (pkgs.dwl.overrideAttrs (finalAttrs: previousAttrs: {
      version = "v0.6";
      src = inputs.dwl-src;
      patches = with inputs; [dwl-alwayscenter-patch dwl-swallow-patch dwl-bar-patch ];
      buildInputs = previousAttrs.buildInputs
        ++ [ pkgs.libdrm pkgs.fcft pkgs.pixman ];
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
  };
}
