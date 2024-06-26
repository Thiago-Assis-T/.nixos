{
  description = "Personal Homelab and Desktop configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim/nixos-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    inputs@{
      nixpkgs,
      disko,
      home-manager,
      ...
    }:
    {
      nixosConfigurations = {
        ThiagoServer = nixpkgs.lib.nixosSystem {
          modules = [
            ./hosts/ThiagoServer/configuration.nix
            disko.nixosModules.disko
            home-manager.nixosModules.home-manager
            inputs.stylix.nixosModules.stylix
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = {
                  inherit inputs;
                };
                users.thiago = import ./home/server.nix;
              };
            }
          ];
        };
        ThiagoDesktop = nixpkgs.lib.nixosSystem {
          modules = [
            ./hosts/ThiagoDesktop/configuration.nix
            disko.nixosModules.disko
            home-manager.nixosModules.home-manager
            inputs.stylix.nixosModules.stylix
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = {
                  inherit inputs;
                };
                users.thiago = import ./home/desktop.nix;
              };
            }
          ];
        };
        ThiagoLaptop= nixpkgs.lib.nixosSystem {
          modules = [
            ./hosts/ThiagoLaptop/configuration.nix
            disko.nixosModules.disko
            home-manager.nixosModules.home-manager
            inputs.stylix.nixosModules.stylix
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
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
