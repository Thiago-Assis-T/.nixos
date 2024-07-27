{
  description = "Personal Homelab and Desktop configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable-small";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neorg-overlay.url = "github:nvim-neorg/nixpkgs-neorg-overlay";

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };
  outputs = inputs@{ nixpkgs, disko, home-manager, ... }:
    let pkgs = import nixpkgs { system = "x86_64-linux"; };
    in {
      nixosConfigurations = {
        ThiagoServer = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/ThiagoServer/configuration.nix
            disko.nixosModules.disko
            home-manager.nixosModules.home-manager
            inputs.stylix.nixosModules.stylix
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = { inherit inputs; };
                users.thiago = import ./home/server.nix;
              };
            }
          ];
        };
        ThiagoDesktop = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs pkgs; };
          modules = [
            ./hosts/ThiagoDesktop/configuration.nix
            disko.nixosModules.disko
            home-manager.nixosModules.home-manager
            inputs.stylix.nixosModules.stylix
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = { inherit inputs; };
                users.thiago = import ./home/desktop.nix;
              };
            }
          ];
        };
        ThiagoLaptop = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs pkgs; };
          modules = [
            ./hosts/ThiagoLaptop/configuration.nix
            disko.nixosModules.disko
            home-manager.nixosModules.home-manager
            inputs.stylix.nixosModules.stylix
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = { inherit inputs; };
                users.thiago = import ./home/laptop.nix;
              };
            }
          ];
        };
      };
    };
}
