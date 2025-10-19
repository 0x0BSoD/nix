{...}: {
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "0x0BSoD";
        email = "zlodey23@gmail.com";
      };

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
        gpgsign = true;
        verbose = true;
      };
      merge.conflictstyle = "diff3";
      color.ui = true;
    };
  };
}
# trace: warning: alex profile: The option `programs.git.userEmail' defined in `/nix/store/5y6r12989wyyk4296qh10wcvlpxy6sh6-source/modules/common/apps/git/git.homeMac.nix' has been renamed to `programs.git.settings.user.email'.
# trace: warning: alex profile: The option `programs.git.userName' defined in `/nix/store/5y6r12989wyyk4296qh10wcvlpxy6sh6-source/modules/common/apps/git/git.homeMac.nix' has been renamed to `programs.git.settings.user.name'.
# trace: warning: alex profile: The option `programs.git.extraConfig' defined in `/nix/store/5y6r12989wyyk4296qh10wcvlpxy6sh6-source/modules/common/apps/git/git.homeMac.nix' has been renamed to `programs.git.settings'.
# trace: warning: alex profile: The option `programs.git.delta.options' defined in `/nix/store/5y6r12989wyyk4296qh10wcvlpxy6sh6-source/modules/common/apps/git/git.homeMac.nix' has been renamed to `programs.delta.options'.
# trace: warning: alex profile: The option `programs.git.delta.enable' defined in `/nix/store/5y6r12989wyyk4296qh10wcvlpxy6sh6-source/modules/common/apps/git/git.homeMac.nix' has been renamed to `programs.delta.enable'.
# trace: warning: alex profile: `programs.delta.enableGitIntegration` automatic enablement is deprecated. Please explicitly set `programs.delta.enableGitIntegration = true`.

