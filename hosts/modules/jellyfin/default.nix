{ pkgs, lib, ... }:
{
  nixpkgs.overlays = lib.singleton (
    lib.const (super: {
      jellyfin-ffmpeg = super.jellyfin-ffmpeg.override {
        ffmpeg_7-full = super.ffmpeg_7-full.override {
          withMfx = false; # This corresponds to the older media driver
          withVpl = true; # This is the new driver
          withUnfree = true;
        };

      };
    })
  );
  environment.systemPackages = with pkgs; [
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
  ];
  services.jellyfin = {
    enable = true;
    openFirewall = true;
    user = "thiago";
  };
}
