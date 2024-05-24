{ config, lib, ... }:
let
  cfg = config.programs.my-git;
in

{

  options.programs.my-git = {
    enable = lib.mkEnableOption (lib.mdDoc "my-git");
  };
  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;
      userName = "Thiago-Assis-T";
      userEmail = "thiago.assisfernandes@gmail.com";
      extraConfig = {
        color = {
          ui = "auto";
        };
        pull = {
          rebase = true;
        };
        core = {
          editor = "nvim";
        };
      };
      includes = [
        {
          contents = {
            init.defaultBranch = "main";
            pull.rebase = true;
            push.autoSetupRemote = true;
          };
        }
      ];
    };
  };
}
