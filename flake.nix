{
  description = "Personal Homelab and Desktop configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nvidia-patch = {
      url = "github:icewind1991/nvidia-patch-nixos";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:danth/stylix";
    wallpaper = {
      url = "file+https://raw.githubusercontent.com/orangci/walls-catppuccin-mocha/master/yohoho.jpg";
      flake = false;
    };
    #nixvim = {
    #  url = "github:nix-community/nixvim";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};
    nvf = {
      url = "github:notashelf/nvf";
      #inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };
  outputs = inputs @ {
    nixpkgs,
    home-manager,
    ...
  }: {
    nixosConfigurations = {
      ThiagoDesktop = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
        };
        modules = [
          ./hosts/ThiagoDesktop/configuration.nix
          home-manager.nixosModules.home-manager
          (import ./overlays)
          (import ./overrides)
          inputs.nixos-hardware.nixosModules.gigabyte-b550
          inputs.nixos-hardware.nixosModules.common-cpu-amd
          inputs.nixos-hardware.nixosModules.common-gpu-amd
          inputs.nixos-hardware.nixosModules.common-pc-ssd
          inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate
          inputs.nixos-hardware.nixosModules.common-cpu-amd-zenpower
          {
            home-manager = {
              extraSpecialArgs = {
                inherit inputs;
              };
              users.thiago = import ./home/desktop.nix;
            };
          }
        ];
      };
      ThiagoServer = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
        };
        modules = [
          ./hosts/ThiagoServer/configuration.nix
          home-manager.nixosModules.home-manager
          (import ./overlays)
          (import ./overrides)
          inputs.nixos-hardware.nixosModules.common-gpu-intel
          inputs.nixos-hardware.nixosModules.common-cpu-intel
          inputs.nixos-hardware.nixosModules.common-gpu-nvidia-disable
          inputs.nixos-hardware.nixosModules.common-pc-ssd
          {
            home-manager = {
              extraSpecialArgs = {
                inherit inputs;
              };
              users.thiago = import ./home/server.nix;
            };
          }
        ];
      };
      ThiagoLaptop = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
        };
        modules = [
          ./hosts/ThiagoLaptop/configuration.nix
          home-manager.nixosModules.home-manager
          inputs.nixos-hardware.nixosModules.common-gpu-intel
          inputs.nixos-hardware.nixosModules.common-cpu-intel
          inputs.nixos-hardware.nixosModules.common-pc-ssd
          inputs.nixos-hardware.nixosModules.common-pc-laptop
          (import ./overlays)
          (import ./overrides)
          {
            home-manager = {
              extraSpecialArgs = {
                inherit inputs;
              };
              users.thiago = import ./home/laptop.nix;
            };
          }
        ];
      };
    };
  };
}
