{ ... }:
{
  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      #enableInspect = true;
    };
    style = '''';

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        #height = 42;
        # width= 1280; # Waybar width
        spacing = 4;
        # Gaps between modules (4px)
        # Choose the order of the modules
        modules-left = [
          #"custom/nixos"
          "hyprland/workspaces"
        ];
        modules-center = [
          "hyprland/window"
        ];
        modules-right = [
          "idle_inhibitor"
          "pulseaudio"
          "network"
          "cpu"
          "memory"
          "temperature"
          #"hyprland/language"
          "battery"
          "battery#bat2"
          "clock"
        ];
        # Modules configuration

        "hyprland/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          warp-on-scroll = false;
          format = "{name}";
          format-icons = {
            urgent = "";
            active = "";
            default = "";
          };
        };

        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = " ";
            deactivated = " ";
          };
        };
      };
    };
  };
}
