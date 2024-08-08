{
  description = "Personal Homelab and Desktop configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neorg-overlay.url = "github:nvim-neorg/nixpkgs-neorg-overlay";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    wallpaper = {
      url =
        "https://raw.githubusercontent.com/Narmis-E/onedark-wallpapers/main/misc/od_current.png";
      #"https://raw.githubusercontent.com/Narmis-E/onedark-wallpapers/main/minimal/od_space01.png";
      #"https://raw.githubusercontent.com/Narmis-E/onedark-wallpapers/main/minimal/od_wave.png";
      #"https://raw.githubusercontent.com/Narmis-E/onedark-wallpapers/main/misc/od_waves.jpg";
      flake = false;
    };
    dwl-src = {
      url =
				#"git+https://codeberg.org/dwl/dwl?rev=5a4839b1c8e1b171441a86a379ef30ddfb687421";
				"git+https://codeberg.org/dwl/dwl?ref=0.7";
      #"git+https://codeberg.org/ThiagoAssis/dwl?ref=personal-v0.6";
      flake = false;
    };
		dwl-alwayscenter-patch = {
			url = "https://codeberg.org/dwl/dwl-patches/raw/branch/main/patches/alwayscenter/alwayscenter.patch";
			flake = false;
		};
    dwl-swallow-patch = {
      url =
        "https://codeberg.org/dwl/dwl-patches/raw/branch/main/patches/swallow/swallow.patch";
      flake = false;
    };
    dwl-bar-patch = {
      url =
        "https://codeberg.org/dwl/dwl-patches/raw/branch/main/patches/bar/bar-0.7.patch";
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
          (import ./overlays)
          (import ./overrides)
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
          (import ./overlays)
          (import ./overrides)
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
