{ ... }:
{
  services.foldingathome = {
    enable = true;
    extraArgs = [
      "on-idle true"
    ];
    daemonNiceLevel = 10;
  };
}
