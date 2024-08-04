{
  description = "Personal Homelab and Desktop configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    wallpaper = {
      url =
        #"https://raw.githubusercontent.com/Narmis-E/onedark-wallpapers/main/misc/od_current.png";
        #"https://raw.githubusercontent.com/Narmis-E/onedark-wallpapers/main/minimal/od_space01.png";
        "https://raw.githubusercontent.com/Narmis-E/onedark-wallpapers/main/minimal/od_wave.png";
      flake = false;
    };
    dwl-src = {
      url = "git+https://codeberg.org/ThiagoAssis/dwl?ref=personal-v0.6";
      flake = false;
    };
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };
  outputs = inputs@{ nixpkgs, disko, home-manager, ... }: {
    nixosConfigurations = {
      ThiagoDesktop = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/ThiagoDesktop/configuration.nix
          disko.nixosModules.disko
          home-manager.nixosModules.home-manager
          inputs.stylix.nixosModules.stylix
          (import ./overlays)
          (import ./overrides)
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
      ThiagoLaptop = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
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
