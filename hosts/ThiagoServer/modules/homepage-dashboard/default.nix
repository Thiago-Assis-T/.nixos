{ ... }:
{
  networking.firewall.allowedTCPPorts = [ 8082 ];
  services.homepage-dashboard = {
    enable = true;
    settings = {
      title = "Server Dashboard";
      background = {
        image = "https://plus.unsplash.com/premium_photo-1661945144631-730dc9775f71?q=80&w=2072&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D";
        blur = "sm";
        saturate = "70";
        brightness = "60";
        opacity = "50";
      };
      theme = "dark";
      color = "slate";
      headerStyle = "underlined";
      layout = {
        Media = {
          style = "columns";
          rows = "4";
        };

        Download = {
          style = "columns";
          rows = "3";
        };
      };
    };
    widgets = [
      {
        resources = {
          cpu = true;
          memory = true;
          disk = "/";
          uptime = true;
        };
      }
      {
        search = {
          provider = "custom";
          url = "https://searxng.site/searxng/search?q=";
          target = "_blank";
        };
      }
      {
        openmeteo = {
          label = "Niteroi - RJ";
          latitude = "22.9038";
          longitude = "43.1222";
          units = "metric";
          timezone = "America/Sao_Paulo";
          cache = "5";
        };
      }
      {
        datetime = {
          text_size = "x1";
          locale = "pt-BR";
          format = {
            timeStyle = "long";
            dateStyle = "short";
            hourCycle = "h23";
          };
        };
      }
    ];
    services = [
      {
        "Media" = [
          {
            "Jellyfin" = {
              icon = "jellyfin.png";
              href = "https://jellyfin.thiagohome.com";
              description = "Media Server";
              widget = {
                type = "jellyfin";
                url = "http://localhost:8096";
                key = "cbb791d5d30449b2a7d359660edc5b0d";
                enableBlocks = true;
                enableNowPlaying = true;
                enableUser = false;
                expandOneStreamToTwoRows = false;
              };
            };
          }
          {
            "Radarr" = {
              icon = "radarr.png";
              href = "http://thiagoserver:7878";
              description = "Movies Manager";
              widget = {
                type = "radarr";
                url = "http://localhost:7878";
                key = "5ab0d61d19c64217aa98cca607b9b72b";
                enableQueue = false;
              };
            };
          }
          {
            "Sonarr" = {
              icon = "sonarr.png";
              href = "http://thiagoserver:8989";
              description = "Shows Manager";
              widget = {
                type = "sonarr";
                url = "http://localhost:8989";
                key = "5d45ca838b4c4fc581f8fbaa05ebe39a";
                enableQueue = false;
              };
            };
          }
          {
            "Jellyseerr" = {
              icon = "jellyseerr.png";
              href = "http://thiagoserver:5055";
              description = "Media Rquest Manager";
              widget = {
                type = "jellyseerr";
                url = "http://localhost:5055";
                key = "MTcxNjY3NTkyNDEyODJjMzE3MDU1LTkyZTUtNDliNi05YjY0LTJjMWZlMGI4MjE4Yw==";
              };
            };
          }
        ];
      }
      {
        "Download" = [
          {
            "Prowlarr" = {
              icon = "prowlarr.png";
              href = "http://thiagoserver:9696";
              description = "Indexers Manager";
              widget = {
                type = "prowlarr";
                url = "http://localhost:9696";
                key = "421d7908397442a6b56f96c4321ef9ac";
              };
            };
          }
          {
            "Bazarr" = {
              icon = "bazarr.png";
              href = "http://thiagoserver:6767";
              description = "Movies Manager";
              widget = {
                type = "bazarr";
                url = "http://localhost:6767";
                key = "125fd690836751bc8cb9e92098ac677b";
              };
            };
          }
          {
            "Deluge" = {
              icon = "deluge.png";
              href = "http://thiagoserver:8112";
              description = "Torrent Downloader";
              widget = {
                type = "deluge";
                url = "http://localhost:8112";
                password = "deluge";
              };
            };
          }
        ];
      }
    ];
  };
}
