{pkgs, ...}: let
  scripts = {
    update-checker = pkgs.writeShellScriptBin "update-checker" ''
      #!/usr/bin/env bash

      cd ~/.nixos || { echo "Failed to change directory"; exit 1; }

      build_output=$(nix flake update nixpkgs && nix build --dry-run .#nixosConfigurations.$HOSTNAME.config.system.build.toplevel 2>&1)

      # Extract information about fetched paths and count how many them
      fetched_info=$(echo "$build_output" | awk '/will be fetched/ {flag=1; next} flag && /^[[:space:]]*\/nix\/store/ {print}'| wc -l)

      # Extract the sizes of fetched paths
      fetched_size=$(echo "$build_output" | grep -oP '\(\K[^)]+(?=\))' | tr '\n' '\n')

      alt="has-updates"
      if [[ $fetched_info -eq 0 ]]; then
        alt="updated"
        fetched_info=""
      fi

      # Output the result
      echo "{ \"text\":\"$fetched_info\", \"alt\":\"$alt\", \"tooltip\":\"$fetched_size\" }"

    '';
  };
in {
  home.packages = [pkgs.nvd pkgs.networkmanagerapplet pkgs.pavucontrol scripts.update-checker];

  services.swaync = {
    enable = true;
    settings = {
      positionX = "right";
      positionY = "top";
      layer = "overlay";
      control-center-layer = "top";
      layer-shell = true;
      cssPriority = "application";
      control-center-margin-top = 0;
      control-center-margin-bottom = 0;
      control-center-margin-right = 0;
      control-center-margin-left = 0;
      notification-2fa-action = true;
      notification-inline-replies = false;
      notification-icon-size = 64;
      notification-body-image-height = 100;
      notification-body-image-width = 200;
      timeout-critical = 60;
    };
  };

  programs.waybar = {
    enable = true;
    style = ''
            * {
          border: none;
          border-radius: 0;
          font-family: "Ubuntu Nerd Font";
          font-size: 13px;
          min-height: 0;
      }

      window#waybar {
          background: transparent;
          color: white;
      }

      #window {
          font-weight: bold;
          font-family: "Ubuntu";
      }
      /*
      #workspaces {
          padding: 0 5px;
      }
      */

      #workspaces button {
          padding: 0 5px;
          background: transparent;
          color: white;
          border-top: 2px solid transparent;
      }

      #workspaces button.focused {
          color: #c9545d;
          border-top: 2px solid #c9545d;
      }

      #mode {
          background: #64727D;
          border-bottom: 3px solid white;
      }

      #clock, #battery, #cpu, #memory, #network, #pulseaudio, #custom-spotify, #tray, #mode {
          padding: 0 3px;
          margin: 0 2px;
      }

      #clock {
          font-weight: bold;
      }

      #battery {
      }

      #battery icon {
          color: red;
      }

      #battery.charging {
      }

      @keyframes blink {
          to {
              background-color: #ffffff;
              color: black;
          }
      }

      #battery.warning:not(.charging) {
          color: white;
          animation-name: blink;
          animation-duration: 0.5s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }

      #cpu {
      }

      #memory {
      }

      #network {
      }

      #network.disconnected {
          background: #f53c3c;
      }

      #pulseaudio {
      }

      #pulseaudio.muted {
      }

      #custom-spotify {
          color: rgb(102, 220, 105);
      }

      #tray {
      }
    '';

    settings = {
      mainBar = {
        layer = "top"; # Waybar at top layer
        position = "top"; # Waybar position (top|bottom|left|right)
        heigh = 24;
        #spacing = 4; # Gaps between modules (4px)
        # Choose the order of the modules
        modules-left = [
          "custom/nixos"
          "hyprland/workspaces"
          "custom/player"
        ];
        modules-center = [
          "hyprland/window"
        ];
        modules-right = [
          "power-profiles-daemon"
          "pulseaudio"
          "network"
          "cpu"
          "memory"
          "battery"
          "tray"
          "clock"
          "custom/notification"
        ];
        "custom/notification" = {
          tooltip = false;
          format = "{} {icon}";
          format-icons = {
            dnd-notification = " ";
            dnd-none = "󰂛";
            inhibited-notification = " ";
            inhibited-none = "";
            dnd-inhibited-notification = " ";
            dnd-inhibited-none = " ";
          };
          return-type = "json";
          exec-if = "which swaync";
          exec = "swaync-client -swb";
          on-click = "sleep 0.1 && swaync-client -t -sw";
          on-click-right = "sleep 0.1 && swaync-client -d -sw";
          escape = true;
        };
        # Modules configuration
        power-profiles-daemon = {
          format = "{icon}";
          tooltip-format = "Power profile: {profile}\nDriver: {driver}";
          tooltip = true;
          format-icons = {
            default = "";
            performance = "";
            balanced = "";
            power-saver = "";
          };
        };
        "custom/player" = {
          format = " 󰦚";
          max-length = 40;
          interval = 30;
        };

        "custom/nixos" = {
          exec = "update-checker";
          on-click = "update-checker && notify-send 'The system has been updated'";
          interval = 3600;
          format = " {} {icon} ";
          tooltip = true;
          return-type = "json";
          format-icons = {
            has-updates = "";
            updated = "";
          };
        };

        "hyprland/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          warp-on-scroll = false;
          format = "{icon}";
          format-icons = {
            urgent = "";
            active = "";
            default = "";
          };
        };
        pulseaudio = {
          format = "{volume}% {icon}";
          format-bluetooth = "{volume}% {icon}  {format_source}";
          format-bluetooth-muted = "󰝟 {icon} {format_source}";
          format-muted = "󰝟 {format_source}";
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
          format-wifi = "{essid} ({signalStrength}%)  ";
          format-ethernet = "Connected 󰌗";
          tooltip-format = "{ifname} via {gwaddr}  ";
          format-linked = "{ifname} (No IP)  ";
          format-disconnected = "Disconnected ⚠";
          on-click = "nm-connection-editor";
        };
        cpu = {
          format = "{usage}% ";
          tooltip = true;
        };
        memory = {
          format = "{}%  ";
          tooltip = true;
        };
        temperature = {
          interval = 10;
          hwmon-path = "/sys/devices/platform/coretemp.0/hwmon/hwmon4/temp1_input";
          critical-threshold = 100;
          format-critical = "{temperatureC}  ";
          format = "{temperatureC}°C  ";
        };
        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon} ";
          format-full = "{capacity}% {icon} ";
          format-charging = "{capacity}% 󱐋 ";
          format-plugged = "{capacity}%  ";
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
          on-click = "thunderbird";
        };
      };
    };
  };
}
