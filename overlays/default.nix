{ inputs, ... }: {
  nixpkgs.overlays = [ inputs.neorg-overlay.overlays.default ];
}
