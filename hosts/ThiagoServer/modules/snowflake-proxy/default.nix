{ ... }:
{
  virtualisation.oci-containers.containers = {
    snowflake-proxy = {
      image = "thetorproject/snowflake-proxy:latest";
      extraOptions = [
        "--network=host"
        "-ephemeral-ports-range 30000:60000"
      ];

    };
  };
}
