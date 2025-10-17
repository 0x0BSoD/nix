{ ... }:

{
  programs.git = {
    enable = true;

    userName = "aleksandr.simonov";
    userEmail = "aleksandr.simonov@exness.com";

    extraConfig = {
      init.defaultBranch = "main";
      merge.conflictstyle = "diff3";
      diff.colorMoved = "default";
      color.ui = true;
      commit.gpgsign = true;
      user = {
        name = "aleksandr.simonov";
        email = "aleksandr.simonov@exness.com";
        signingkey = "82814D830070E87A";
      };
      pull = {
        rebase = false;
        ff = "only";
      };
    };

    delta = {
      enable = true;
      options = {
        line-numbers = true;
        side-by-side = false;
        diff-so-fancy = true;
        navigate = true;
      };
    };
  };

  xdg.configFile."git/.gitignore".text = ''
    .vscode
    ._DS_Store
    .idea
  '';
}
