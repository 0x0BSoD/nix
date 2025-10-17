{ ... }:

{
  programs.zsh = {
    enable = true;

    # enableCompletion = true;

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    plugins = [
    ];

    completionInit = ''
      autoload bashcompinit && bashcompinit
      complete -C '$(which aws_completer)' aws
      autoload -Uz compinit
      if [ "$(date +'%j')" != "$(stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)" ]; then
          compinit
      else
          compinit -C
      fi
    '';

    initContent = ''
      # Use this setting if you want to disable marking untracked files under VCS as dirty.
      # This makes repository status checks for large repositories much, much faster.
      DISABLE_UNTRACKED_FILES_DIRTY="true"
      COMPLETION_WAITING_DOTS=true

      setopt NO_BEEP # Don't beep on errors.

      # History
      HISTFILE="$HOME/.zsh_history"
      HISTIGNORE="&:exit:reset:clear:zh"
      setopt EXTENDED_HISTORY # Save each command's epoch timestamps and the duration in seconds.
      setopt HIST_EXPIRE_DUPS_FIRST # Expire duplicate entries first when trimming history.
      setopt HIST_REDUCE_BLANKS # Remove superfluous blanks before recording an entry.
      setopt HIST_IGNORE_DUPS # Don't record an entry that was just recorded again.
      setopt HIST_IGNORE_SPACE # Don't record an entry starting with a space.
      setopt HIST_VERIFY # Don't execute the line directly instead perform history expansion.
      setopt INC_APPEND_HISTORY # Write to the history file immediately, not when the shell exits.
      setopt SHARE_HISTORY # Share history between all sessions.
    '';
  };

  imports = [
    ./zoxide.nix
    ./starship.nix
  ];
}
