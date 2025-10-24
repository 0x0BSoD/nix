{...}: {
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "0x0BSoD";
        email = "zlodey23@gmail.com";
      };

      merge.conflictstyle = "diff3";
      color.ui = true;
      column.ui = "auto";
      branch.sort = "-commiterdate";
      tag.sort = "version:refname";
      init.defaultBranch = "main";

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
        gpgsign = false;
        verbose = true;
      };
    };
  };
}
