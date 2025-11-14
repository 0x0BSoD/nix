{...}: {
  # programs.ghostty.enable = true;

  xdg.configFile."ghostty/config".source = ./config;

  home.file.".config/ghostty/startup.sh" = {
    text = ''
      #!/bin/bash
      export PATH="/etc/profiles/per-user/$USER/bin:$HOME/.nix-profile/bin:/run/current-system/sw/bin:$PATH"
      SESSION_NAME="ghostty"
      if tmux has-session -t $SESSION_NAME 2>/dev/null; then
        tmux attach-session -t $SESSION_NAME
      else
        tmux new-session -s $SESSION_NAME -d
        tmux attach-session -t $SESSION_NAME
      fi
    '';
    executable = true;
  };
}
