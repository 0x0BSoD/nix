{
  name,
  email,
  signingKey ? null,
  ...
}: {
  programs.git = {
    enable = true;

    settings = {
      user =
        {
          inherit name email;
        }
        // (
          if signingKey != null
          then {signingkey = signingKey;}
          else {}
        );

      color.ui = true;
      column.ui = "auto";
      init.defaultBranch = "main";
      merge.conflictstyle = "diff3";

      branch.sort = "-committerdate";
      tag.sort = "version:refname";

      diff = {
        algorithm = "histogram";
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

      # Reject corrupt objects instead of silently accepting them.
      transfer.fsckObjects = true;
      fetch.fsckObjects = true;
      receive.fsckObjects = true;

      commit = {
        gpgsign = signingKey != null;
        verbose = true;
      };
    };
  };
}
