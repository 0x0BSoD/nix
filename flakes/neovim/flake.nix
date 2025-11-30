{
  description = "Neovim flake";
  inputs = {
    # Core ===========================
    nixpkgs = {
      url = "github:NixOS/nixpkgs";
    };
    neovim = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Plugins ===========================
    telescope-recent-files-src = {
      url = "github:smartpde/telescope-recent-files";
      flake = false;
    };
  };
  outputs = {
    self,
    nixpkgs,
    neovim,
    telescope-recent-files-src,
  }: let
    overlayFlakeInputs = prev: final: {
      neovim = neovim.packages.aarch64-darwin.neovim;

      vimPlugins =
        final.vimPlugins
        // {
          telescope-recent-files = import ./packages/vimPlugins/telescopeRecentFiles.nix {
            src = telescope-recent-files-src;
            pkgs = prev;
          };
        };
    };

    overlayMyNeovim = prev: final: {
      myNeovim = import ./packages/neovim.nix {
        pkgs = final;
      };
    };

    pkgs = import nixpkgs {
      system = "aarch64-darwin";
      overlays = [overlayFlakeInputs overlayMyNeovim];
    };
  in {
    packages.aarch64-darwin.default = pkgs.myNeovim;
    apps.aarch64-darwin.default = {
      type = "app";
      program = "${pkgs.myNeovim}/bin/nvim";
    };
  };
}
