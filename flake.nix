{
  description = "0x0bsod";

  inputs = {
    # Main =======
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # OSX =======
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-25.11";
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
    sergioBenitez-osxct = {
      url = "github:SergioBenitez/homebrew-osxct";
      flake = false;
    };
    darksworm-tap = {
      url = "github:darksworm/homebrew-tap";
      flake = false;
    };

    # Other
    ghostty = {
      url = "github:ghostty-org/ghostty";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-gaming.url = "github:fufexan/nix-gaming";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    vicinae.url = "github:vicinaehq/vicinae";
    vicinae-extensions.url = "github:vicinaehq/extensions";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    zen-browser.url = "github:0xc000022070/zen-browser-flake/beta";
    # neovim-flake.url = "path:/Users/aleksandr.simonov/Projects/My/nvim-flake";
    # neovim-flake.url = "github:0x0BSoD/nvim-flake";
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
            ({config, ...}: {
              homebrew.taps = builtins.attrNames config.nix-homebrew.taps;
            })
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
      work = mkDarwin "aleksandr.simonov" [
        ./hosts/darwin/work/configuration.nix
        ./hosts/darwin/work/homebrew.nix
        ./hosts/darwin/work/user.nix
      ];
      macbook = mkDarwin "alex" [
        ./hosts/darwin/home/configuration.nix
        ./hosts/darwin/home/homebrew.nix
        ./hosts/darwin/home/user.nix
      ];
    };
    nixosConfigurations = {
      blackrock = mkNixos "alex" [
        ./hosts/linux/common.nix
        ./hosts/linux/blackrock/configuration.nix
        ./hosts/linux/blackrock/user.nix
      ];
    };
    nixosConfigurations = {
      tpad = mkNixos "alex" [
        ./hosts/linux/common.nix
        ./hosts/linux/tpad/configuration.nix
        ./hosts/linux/tpad/user.nix
      ];
    };
  };
}
