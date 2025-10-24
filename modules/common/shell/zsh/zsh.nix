{...}: {
  programs.zsh = {
    enable = true;

    enableCompletion = false;

    #   autosuggestion.enable = false;
    #   syntaxHighlighting.enable = false;

    # initContent = ''
    #   complete -o default -o nospace -F _kubectl k
    # '';

    #   oh-my-zsh = {
    #     enable = true;
    #     extraConfig = ''
    #       DISABLE_UNTRACKED_FILES_DIRTY="true"
    #       COMPLETION_WAITING_DOTS=true
    #       zstyle ':omz:update' mode disabled # Disable auto update
    #     '';
    #     plugins = [
    #       "fzf"
    #     ];
    #   };

    #   setOptions = [
    #     "EXTENDED_HISTORY"
    #     "HIST_EXPIRE_DUPS_FIRST"
    #     "HIST_REDUCE_BLANKS"
    #     "HIST_IGNORE_DUPS"
    #     "HIST_IGNORE_SPACE"
    #     "HIST_VERIFY"
    #     "INC_APPEND_HISTORY"
    #     "SHARE_HISTORY"
    #     "NO_BEEP"
    #   ];
  };

  imports = [
    # ./zoxide.nix
    # ./starship.nix
  ];
}
