{
  description = "0x0bsod";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mac-app-util = {
      url = "github:hraban/mac-app-util";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew";
    };

    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };

    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
  };

  outputs = {
    self,
    nix-darwin,
    home-manager,
    mac-app-util,
    nix-homebrew,
    homebrew-core,
    homebrew-cask,
    ...
  }: let
    mkDarwin = primaryUser: modules:
      nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = {
          inherit self primaryUser;
        };
        modules =
          modules
          ++ [
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
            }
            mac-app-util.darwinModules.default
            nix-homebrew.darwinModules.nix-homebrew
            {
              nix-homebrew = {
                enable = true;
                enableRosetta = true;
                user = primaryUser;
                autoMigrate = true;
                mutableTaps = false;

                taps = {
                  "homebrew/homebrew-core" = homebrew-core;
                  "homebrew/homebrew-cask" = homebrew-cask;
                };
              };
            }
          ];
      };
    #mkNixos =
    #  name: modules:
    #  nixpkgs.lib.nixosSystem {
    #    system = "x86_64-linux";
    #    modules = modules ++ [
    #      home-manager.nixosModules.home-manager
    #      {
    #        home-manager.useGlobalPkgs = true;
    #        home-manager.useUserPackages = true;
    #      }
    #    ];
    #  };
  in {
    darwinConfigurations = {
      exness = mkDarwin "aleksandr.simonov" [
        ./hosts/work/configuration.nix
        ./hosts/work/user.nix
      ];
      homeMac = mkDarwin "alex" [
        ./hosts/homeMac/configuration.nix
        ./hosts/homeMac/user.nix
      ];
    };
  };
}
