{ lib, pkgs, config, ... }: {
  options.tools.kubernetes.k3s.enable = lib.mkEnableOption "k3s/vagrant" // { default = true; };

  config = lib.mkIf config.tools.kubernetes.k3s.enable {
    home.packages = [ pkgs.vagrant ];
  };
}
