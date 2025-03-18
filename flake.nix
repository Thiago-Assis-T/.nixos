{
  description = "Personal Homelab and Desktop configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:danth/stylix";
    wallpaper = {
      url = "https://images6.alphacoders.com/134/1346530.jpeg";
      flake = false;

    };
    # dwl.url = "github:Thiago-Assis-T/dwl";

  };
  outputs =
    inputs@{
      nixpkgs,
      home-manager,
      ...
    }:
    {
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
            #(import ./overlays)
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
