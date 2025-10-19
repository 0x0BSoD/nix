{pkgs, ...}: {
  users.users.alex = {
    name = "alex";
    home = "/Users/alex";
  };

  home-manager.users.alex = {
    home.stateVersion = "25.11";

    home.packages = with pkgs; [
      alejandra
      bottom
      curlie
      dog
      duf
      dust
      fd
      fx
      gawk
      gnupg
      go
      jq
      k9s
      kubecolor
      kubectl
      kubectx
      lsd
      neovim
      nil
      nixd
      pinentry_mac
      procs
      ripgrep
      starship
      stern
      viddy
      yq
      zoxide
    ];

    imports = [
      ../../modules/common/shell

      ../../modules/common/apps/bat.nix
      ../../modules/common/apps/btop.nix
      ../../modules/common/apps/fzf.nix
      ../../modules/common/apps/delta.nix
      ../../modules/common/apps/git/git.homeMac.nix
      ../../modules/common/apps/alacritty.nix
      ../../modules/common/apps/zed.nix
    ];
  };
}
