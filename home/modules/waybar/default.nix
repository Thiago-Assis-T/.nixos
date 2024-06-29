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
          modules-left = [
            "hyprland/workspaces"
            "hyprland/window"
          ];
          modules-center = [ "clock" ];
          clock = {
            interval = 1;
            format = "  {:%H:%M:%S}";
            timezone = "America/Sao_Paulo";
          };
          modules-right = [
            "tray"
            "cpu"
            "temperature"
            "pulseaudio"
            "custom/notification"
          ];
          tray = {
            spacing = 8;
          };
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
          "pulseaudio" = {
            format = "{volume}% {icon}   ";
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
          "custom/notification" = {
            tooltip = false;
            format = "{icon}";
            format-icons = {
              notification = "<span foreground='red'><sup></sup></span>";
              none = "";
              dnd-notification = "<span foreground='red'><sup></sup></span>";
              dnd-none = "";
              inhibited-notification = "<span foreground='red'><sup></sup></span>";
              inhibited-none = "";
              dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>";
              dnd-inhibited-none = "";
            };
            return-type = "json";
            exec-if = "which swaync-client";
            exec = "swaync-client -swb";
            on-click = "swaync-client -t -sw";
            on-click-right = "swaync-client -d -sw";
            escape = true;
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
