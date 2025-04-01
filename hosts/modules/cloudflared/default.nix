{ ... }:
{
  services.cloudflared = {
    enable = true;
    tunnels = {
      "00000000-0000-0000-0000-000000000000" = {
        credentialsFile = ./cert.pem;
        default = "http_status:404";
      };
    };
  };

}
