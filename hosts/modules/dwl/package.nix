{ pkgs, patches, dwl-source, ... }:
(pkgs.dwl.overrideAttrs (finalAttrs: previousAttrs: {
  version = "v0.5";
  src = dwl-source;
  inherit patches;
  passthru.providedSessions = [ "dwl" ];
})) # .override { conf = ./config.h; }
