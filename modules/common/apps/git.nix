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
      pull.ff = "only";
      color.ui = true;
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
  '';
}
