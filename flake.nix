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
  };

  outputs =
    {
      self,
      nix-darwin,
      home-manager,
      ...
    }:
    let
      mkDarwin =
        name: modules:
        nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          specialArgs = {
            inherit self;
          };
          modules = modules ++ [
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
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
    in
    {
      darwinConfigurations = {
        exness = mkDarwin "work" [
          ./hosts/work/configuration.nix
          ./hosts/work/user.nix
        ];
      };
    };
}
