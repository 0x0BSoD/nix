{
  description = "0x0bsod";

  inputs = {
    # Main =======
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # OSX =======
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mac-app-util = {
      url = "github:hraban/mac-app-util";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ## Homebrew
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };

    # Other
    nix-gaming.url = "github:fufexan/nix-gaming";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    vicinae.url = "github:vicinaehq/vicinae";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    zen-browser.url = "github:0xc000022070/zen-browser-flake/beta";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    mkDarwin = primaryUser: modules:
      inputs.nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = {
          inherit self inputs primaryUser;
        };
        modules =
          modules
          ++ [
            home-manager.darwinModules.home-manager
            inputs.nix-homebrew.darwinModules.nix-homebrew
            # inputs.mac-app-util.darwinModules.default
          ];
      };

    mkNixos = primaryUser: modules:
      nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit self inputs primaryUser;
        };
        modules =
          modules
          ++ [
            home-manager.nixosModules.home-manager
          ];
      };
  in {
    darwinConfigurations = {
      exness = mkDarwin "aleksandr.simonov" [
        ./hosts/work/configuration.nix
        ./hosts/work/user.nix
      ];
      homeMac = mkDarwin "alex" [
        ./hosts/homeMac/configuration.nix
        ./hosts/homeMac/homebrew.nix
        ./hosts/homeMac/user.nix
      ];
    };
    nixosConfigurations = {
      homePc = mkNixos "alex" [
        ./hosts/homePc/configuration.nix
        ./hosts/homeMac/homebrew.nix
        ./hosts/homePc/user.nix
      ];
    };
  };
}
