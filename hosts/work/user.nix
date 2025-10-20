{...}: {
  users.users."aleksandr.simonov" = {
    name = "aleksandr.simonov";
    home = "/Users/aleksandr.simonov";
  };

  home-manager.users."aleksandr.simonov" = {
    home.stateVersion = "25.11";

    imports = [
      ../../modules/common/apps/other.nix

      ../../modules/common/shell

      ../../modules/common/apps/bat.nix
      ../../modules/common/apps/btop.nix
      ../../modules/common/apps/fzf.nix
      ../../modules/common/apps/delta.nix
      ../../modules/common/apps/git/git.work.nix
      ../../modules/common/apps/alacritty.nix
      ../../modules/common/apps/zed.nix
      ../../modules/common/apps/k9s.nix
    ];
  };
}
