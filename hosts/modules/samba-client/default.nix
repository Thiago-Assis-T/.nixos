{ pkgs, ... }:
{
  networking.firewall.extraCommands = ''iptables -t raw -A OUTPUT -p udp -m udp --dport 137 -j CT --helper netbios-ns'';
  environment.systemPackages = [ pkgs.cifs-utils ];
  fileSystems."/home/thiago/data" = {
    device = "//192.168.8.233/data";
    fsType = "cifs";
    options =
      let
        automount_opts = "x-systemd.automount,noauto,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,user,users";

      in
      [ "${automount_opts},credentials=/etc/nixos/smb-secrets,uid=1000,gid=1000" ];
  };

}
