{
  pkgs,
  lib,
  ...
}: {
  services.foldingathome = {
    enable = false;
    package = pkgs.fahclient.override {
      extraPkgs = with pkgs; [
        rocmPackages.llvm.libcxx
        libcxx
      ];
    };
  };
  systemd.tmpfiles.rules = let
    rocmEnv = pkgs.symlinkJoin {
      name = "rocm-combined";
      paths = with pkgs.rocmPackages; [
        clr
        hipblas
        rocblas
      ];
    };
  in [
    "L+ /opt/rcom - - - - ${rocmEnv}"
  ];

  virtualisation.oci-containers.containers = {
    foldingathome = {
      image = "docker.io/foldingathome/fah-gpu-amd:latest";
      ports = [
        "7396:7396"
      ];
      extraOptions = ["--security-opt" "seccomp=unconfined" "--group-add" "video" "--group-add" "1001"];
      volumes = [
        "/home/thiago/foldingathome:/fah"
        "/dev/dri:/dev/dri"
        "/dev/kfd:/dev/kfd"
      ];
      environment = {
        PUID = "1000";
        GUID = "1000";
        TZ = "America/Sao_Paulo";
        ACCOUNT_TOKEN = "YjY8TYjZZynf7Zyn3S6rP3S6HGu4-HGv9o6bn9o5e4U";
      };
    };
  };

  environment.systemPackages = with pkgs; [clinfo];
}
