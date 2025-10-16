{ ... }:

{
  users.users."aleksandr.simonov" = {
    name = "aleksandr.simonov";
    home = "/Users/aleksandr.simonov";
  };

  home-manager.users."aleksandr.simonov" = {
    home.stateVersion = "25.11";
    imports = [
      ../../modules/common
    ];
  };
}
