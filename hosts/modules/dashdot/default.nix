{ ... }:
{
  virtualisation.oci-containers.containers = {
    dashdot = {
      image = "mauricenino/dashdot:latest";
      privileged = true;
      ports = [
        "3001:3001"
      ];
      volumes = [
        "/:/mnt/host:ro"
      ];
      environment = {
        DASHDOT_WIDGET_LIST = "os,cpu,storage,ram,network";
        DASHDOT_PAGE_TITLE = "System Monitoring";
        DASHDOT_ALWAYS_SHOW_PERCENTAGES = "true";
        DASHDOT_OVERRIDE_OS = "NixOS 25.05 (Warbler)";
      };
    };
  };
}
