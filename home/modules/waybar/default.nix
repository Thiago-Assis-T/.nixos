{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.programs.my-hyprland;
in
{
  options.programs.my-waybar = {
    enable = lib.mkEnableOption (lib.mdDoc "my-waybar");
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ pavucontrol ];

    programs.waybar = {
      enable = true;
      systemd = {
        enable = true;
        target = "hyprland-session.target";
      };
      settings = {
        mainBar = {
          layer = "top";
          position = "top";
          spacing = 5;
          output = [ "HDMI-A-1" ];
          modules-left = [ "hyprland/workspaces" ];
          modules-center = [ "hyprland/window" ];
          modules-right = [
            "cpu"
            "temperature"
            #"pulseaudio/slider"
            "pulseaudio"
            "tray"
          ];
          cpu = {
            interval = 1;
            format = "{usage}% ";
          };
          temperature = {
            interval = 1;
            hwmon-path = "/sys/class/hwmon/hwmon1/temp1_input";
            critical-threshold = 80;
            format = "{temperatureC} °C ";
            format-critical = "{temperatureC} °C ";
          };
          "pulseaudio/slider" = {
            on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
            orientation = "horizontal";
          };
          "pulseaudio" = {
            format = "{volume}% {icon}";
            format-muted = "";
            on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
            format-icons = {
              default = [
                ""
                ""
                ""
              ];
            };
          };
        };
      };
      style = ''
        * {
            font-size: 5px;
            min-height: 0;
        }
        #pulseaudio-slider slider {
            min-height: 1px;
            min-width: 1px;
            border: none;
            opacity: 0;
            background-image: none;
            box-shadow: none;
        }
        #pulseaudio-slider trough {
            min-height: 5px;
            min-width: 80px;
            border-radius: 5px;
            background-color: gray;
        }
        #pulseaudio-slider highlight {
            min-width: 2px;
            border-radius: 5px;
            background-color: silver;
        }
      '';
    };
  };
}
