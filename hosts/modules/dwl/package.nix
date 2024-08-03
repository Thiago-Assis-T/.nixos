{ pkgs, patches, dwl-source, ... }:
(pkgs.dwl.overrideAttrs (finalAttrs: previousAttrs: {
  version = "v0.6";
  src = dwl-source;
  inherit patches;
  buildInputs = previousAttrs.buildInputs
    ++ [ pkgs.libdrm pkgs.fcft pkgs.pixman ];
  passthru.providedSessions = [ "dwl" ];
})).override { configH = ./config.h; }
