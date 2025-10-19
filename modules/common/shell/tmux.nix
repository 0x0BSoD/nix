{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "tmux-256color";
    historyLimit = 20000;
    keyMode = "vi";

    plugins = with pkgs; [
      tmuxPlugins.nord
    ];

    extraConfig = ''
      # ==========================
      # ===  General settings  ===
      # ==========================
      set -g status-position top
      set -g focus-events on
      set -q -g status-utf8 on
      setw -q -g utf8 on

      set -g buffer-limit 20
      set -g remain-on-exit off
      setw -g aggressive-resize on

      set -g repeat-time 300
      set -sg escape-time 0
      set -g display-time 1500

      setw -g allow-rename off
      setw -g automatic-rename on
      set -g renumber-windows on

      # Set parent terminal title to reflect current window in tmux session
      set -g set-titles on
      set -g set-titles-string "#I:#W"

      # Start index of window/pane with 1
      set -g base-index 1
      setw -g pane-base-index 1

      # Enable mouse support
      set -g mouse on

      # # ==========================
      # # ===   Key bindings     ===
      # # ==========================
      bind -n 'C-h' if-shell "[ #{pane_current_command} = nvim ]" 'send-keys C-h' "select-pane -L"
      bind -n 'C-j' if-shell "[ #{pane_current_command} = nvim ]" 'send-keys C-j' "select-pane -D"
      bind -n 'C-k' if-shell "[ #{pane_current_command} = nvim ]" 'send-keys C-k' "select-pane -U"
      bind -n 'C-l' if-shell "[ #{pane_current_command} = nvim ]" 'send-keys C-l' "select-pane -R"

      bind -T copy-mode-vi 'C-h' if -F "#{pane_at_left}" "" "select-pane -L"
      bind -T copy-mode-vi 'C-j' if -F "#{pane_at_bottom}" "" "select-pane -D"
      bind -T copy-mode-vi 'C-k' if -F "#{pane_at_top}" "" "select-pane -U"
      bind -T copy-mode-vi 'C-l' if -F "#{pane_at_right}" "" "select-pane -R"

      # Copy mode
      bind Enter copy-mode
      bind -T copy-mode-vi v send -X begin-selection
      bind -T copy-mode-vi C-v send -X rectangle-toggle
      bind -T copy-mode-vi y send -X copy-selection-and-cancel
      bind -T copy-mode-vi Escape send -X cancel
      bind -T copy-mode-vi H send -X start-of-line
      bind -T copy-mode-vi L send -X end-of-line

      bind b list-buffers
      bind p paste-buffer -p
      bind P choose-buffer

      # Alt + <number> to switch to window
      bind -n M-1 select-window -t 1
      bind -n M-2 select-window -t 2
      bind -n M-3 select-window -t 3
      bind -n M-4 select-window -t 4
      bind -n M-5 select-window -t 5
      bind -n M-6 select-window -t 6
      bind -n M-7 select-window -t 7
      bind -n M-8 select-window -t 8
      bind -n M-9 select-window -t 9

      # Edit configuration and reload
      bind C-e new-window -n 'tmux.conf' "sh -c '\${"EDITOR:-vim"} ~/.tmux.conf && tmux source ~/.tmux.conf && tmux display \"Config reloaded\"'"

      # Reload tmux configuration
      bind C-r source-file ~/.tmux.conf \; display "Config reloaded"

      # new window and retain cwd
      bind c new-window -c "#{pane_current_path}"

      # Rename session and window
      bind r command-prompt -I "#{window_name}" "rename-window '%%'"
      bind R command-prompt -I "#{session_name}" "rename-session '%%'"

      # Split panes
      bind | split-window -h -c "#{pane_current_path}"
      bind _ split-window -v -c "#{pane_current_path}"

      # Kill pane/window/session shortcuts
      bind x kill-pane
      bind X kill-window
      bind C-x confirm-before -p "kill other windows? (y/n)" "kill-window -a"
      bind Q confirm-before -p "kill-session #S? (y/n)" kill-session

      # Merge session with another one (e.g. move all windows)
      # If you use adhoc 1-window sessions, and you want to preserve session upon exit
      # but don't want to create a lot of small unnamed 1-window sessions around
      # move all windows from current session to main named one (dev, work, etc)
      bind C-u command-prompt -p "Session to merge with: " \
         "run-shell 'yes | head -n #{session_windows} | xargs -I {} -n 1 tmux movew -t %%'"

      # Detach from session
      bind d detach
      bind D if -F '#{session_many_attached}' \
          'confirm-before -p "Detach other clients? (y/n)" "detach -a"' \
          'display "Session has only 1 client attached"'

      # Hide status bar on demand
      bind C-s if -F '#{s/off//:status}' 'set status off' 'set status on'

      # ==================================================
      # === Window monitoring for activity and silence ===
      # ==================================================
      bind m setw monitor-activity \; display-message 'Monitor window activity [#{?monitor-activity,ON,OFF}]'
      bind M if -F '#{monitor-silence}' \
          'setw monitor-silence 0 ; display-message "Monitor window silence [OFF]"' \
          'command-prompt -p "Monitor silence: interval (s)" "setw monitor-silence %%"'

      # Activity bell and whistles
      set -g visual-activity on

      set -g visual-silence on

      # BUG: bell-action other ignored · Issue #1027 · tmux/tmux · GitHub - https://github.com/tmux/tmux/issues/1027
      set -g visual-bell on
      setw -g bell-action other

      # ================================================
      # ===     Copy mode, scroll and clipboard      ===
      # ================================================
      set -g @copy_use_osc52_fallback on

      # Prefer vi style key table
      setw -g mode-keys vi

      bind p paste-buffer
      bind C-p choose-buffer

      # trigger copy mode by
      bind -n M-Up copy-mode

      # Scroll up/down by 1 line, half screen, whole screen
      bind -T copy-mode-vi M-Up              send-keys -X scroll-up
      bind -T copy-mode-vi M-Down            send-keys -X scroll-down
      bind -T copy-mode-vi M-PageUp          send-keys -X halfpage-up
      bind -T copy-mode-vi M-PageDown        send-keys -X halfpage-down
      bind -T copy-mode-vi PageDown          send-keys -X page-down
      bind -T copy-mode-vi PageUp            send-keys -X page-up

      # When scrolling with mouse wheel, reduce number of scrolled rows per tick to "2" (default is 5)
      bind -T copy-mode-vi WheelUpPane       select-pane \; send-keys -X -N 2 scroll-up
      bind -T copy-mode-vi WheelDownPane     select-pane \; send-keys -X -N 2 scroll-down
    '';
  };
}
