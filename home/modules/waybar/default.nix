{ ... }:
{
  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
    };
    style = ''
      * {
          /* `otf-font-awesome` and SpaceMono Nerd Font are required to be installed for icons */
          font-size: 15px;
      }
      window#waybar.empty #window {
      background-color: transparent;
      background: transparent;
      }

      .modules-left,
      .modules-center,
      .modules-right
      {
          background: rgba(0, 0, 8, .7);
          margin: 5px 10px;
          padding: 0 5px;
          border-radius: 15px;
      }
      .modules-left {
          padding: 0;
      }
      .modules-center {
          padding: 0 10px;
      }

      #clock,
      #battery,
      #cpu,
      #memory,
      #disk,
      #temperature,
      #backlight,
      #network,
      #pulseaudio,
      #wireplumber,
      #custom-media,
      #tray,
      #mode,
      #idle_inhibitor,
      #scratchpad,
      #power-profiles-daemon,
      #language,
      #mpd {
          padding: 0 10px;
          border-radius: 15px;
      }

      #clock:hover,
      #battery:hover,
      #cpu:hover,
      #memory:hover,
      #disk:hover,
      #temperature:hover,
      #backlight:hover,
      #network:hover,
      #pulseaudio:hover,
      #wireplumber:hover,
      #custom-media:hover,
      #tray:hover,
      #mode:hover,
      #idle_inhibitor:hover,
      #scratchpad:hover,
      #power-profiles-daemon:hover,
      #language:hover,
      #mpd:hover {
          background: rgba(26, 27, 38, 0.9);
      }


      #workspaces button {
        background: transparent;
        font-weight: 900;
        font-size: 13pt;
        color: #c0caf5;
        border:none;
        border-radius: 15px;
      }

      #workspaces button.active {
          background: #13131d; 
      }

      #workspaces button:hover {
        background: #11111b;
        color: #cdd6f4;
        box-shadow: none;
      }

      #custom-nixos{
          margin-left: 5px;
          padding: 0 10px;
          font-size: 25px;
          transition: color .5s;
      }
      #custom-nixos:hover {
          color: #1793d1;
      }
    '';

    settings = {
      mainBar = {
        layer = "top"; # Waybar at top layer
        position = "top"; # Waybar position (top|bottom|left|right)
        #spacing = 4; # Gaps between modules (4px)
        # Choose the order of the modules
        modules-left = [
          "custom/nixos"
          "hyprland/workspaces"
        ];
        modules-center = [
          "hyprland/window"
        ];
        modules-right = [
          "pulseaudio"
          "network"
          "cpu"
          "memory"
          "temperature"
          "battery"
          "clock"
        ];
        # Modules configuration
        "custom/nixos" = {
          format = " ";
          tooltip = true;
          tooltip-format = "btw";
        };

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
        pulseaudio = {
          format = "{icon}  {volume}%";
          format-bluetooth = "{icon} {volume}%  {format_source}";
          format-bluetooth-muted = " {icon} {format_source}";
          format-muted = " {format_source}";
          format-source = " {volume}%";
          format-source-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [
              ""
              ""
              ""
            ];
          };
          on-click = "pavucontrol";
        };
        network = {
          format-wifi = "   {essid} ({signalStrength}%)";
          format-ethernet = "Connected 󰌗";
          tooltip-format = "{ifname} via {gwaddr}  ";
          format-linked = "{ifname} (No IP)  ";
          format-disconnected = "Disconnected ⚠";
          on-click = "wezterm -e nmtui";

        };
        cpu = {
          format = "  {usage}%";
          tooltip = true;
        };
        memory = {
          format = "  {}%";
          tooltip = true;
        };
        temperature = {
          interval = 10;
          hwmon-path = "/sys/devices/platform/coretemp.0/hwmon/hwmon4/temp1_input";
          critical-threshold = 100;
          format-critical = " {temperatureC}";
          format = " {temperatureC}°C";
        };
        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon}  {capacity}%";
          format-full = "{icon}  {capacity}%";
          format-charging = "󱐋  {capacity}%";
          format-plugged = "  {capacity}%";
          format-alt = "{time}  {icon}";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
        };
        clock = {
          format = "{:%H:%M | %e %B} ";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format-alt = "{:%Y-%m-%d}";
        };
      };
    };
  };
}
