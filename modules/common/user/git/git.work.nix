{...}: {
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "aleksandr.simonov";
        email = "aleksandr.simonov@exness.com";
        signingkey = "82814D830070E87A";
      };

      color.ui = true;
      column.ui = "auto";
      init.defaultBranch = "main";
      merge.conflictstyle = "diff3";

      branch.sort = "-commiterdate";
      tag.sort = "version:refname";

      diff = {
        algoritm = "histogram";
        colorMoved = "plain";
        mnemonicPrefix = true;
        renames = true;
      };

      push = {
        default = "simple";
        autoSetupRemote = true;
        followTags = true;
      };

      pull = {
        rebase = true;
        ff = "only";
      };

      rebase = {
        autoSquash = true;
        autoStash = true;
        updateRefs = true;
      };

      fetch = {
        prune = true;
        pruneTags = true;
        all = true;
      };

      commit = {
        gpgsign = true;
        verbose = true;
      };
    };
  };
}
