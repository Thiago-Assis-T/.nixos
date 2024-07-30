{ pkgs, patches, dwl-source, ... }:
(pkgs.dwl.overrideAttrs (finalAttrs: previousAttrs: {
  version = "v0.6";
  src = dwl-source;
  inherit patches;
  passthru.providedSessions = [ "dwl" ];
})).override { conf = ./config.h; }
