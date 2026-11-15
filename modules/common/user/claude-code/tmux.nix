# tmux integration: Claude Code hooks mirror session state into window options,
# and tmux's automatic-rename shows "<state> <project>" for windows running Claude.
#   busy -> braille spinner, wait (permission/question) -> ●, done -> ✓
# shortcut: state is per window, so two Claude panes in one window overwrite each other; move to pane options if that matters.
{
  config,
  lib,
  pkgs,
  ...
}: let
  tmux = "${config.programs.tmux.package}/bin/tmux";

  stateHook = pkgs.writeShellScript "claude-tmux-state" ''
    [ -n "$TMUX_PANE" ] || exit 0
    t="$TMUX_PANE"
    case "$1" in
      off)
        ${tmux} set -wu -t "$t" @claude_state
        ${tmux} set -wu -t "$t" @claude_spin
        ;;
      busy)
        prev=$(${tmux} show -wv -t "$t" @claude_state 2>/dev/null)
        ${tmux} set -w -t "$t" @claude_state busy
        # Start the spinner only on transition; it stops itself once state leaves busy or the pane dies.
        [ "$prev" = busy ] && exit 0
        ${tmux} set -w -t "$t" @claude_spin ⠋
        (
          i=0
          while [ "$(${tmux} show -wv -t "$t" @claude_state 2>/dev/null)" = busy ]; do
            set -- ⠋ ⠙ ⠹ ⠸ ⠼ ⠴ ⠦ ⠧ ⠇ ⠏
            shift $((i % 10))
            ${tmux} set -w -t "$t" @claude_spin "$1"
            i=$((i + 1))
            sleep 0.2
          done
        ) </dev/null >/dev/null 2>&1 &
        ;;
      *) ${tmux} set -w -t "$t" @claude_state "$1" ;;
    esac
    exit 0
  '';

  hook = state: matcher:
    {
      hooks = [
        {
          type = "command";
          command = "${stateHook} ${state}";
          timeout = 5;
        }
      ];
    }
    // lib.optionalAttrs (matcher != null) {inherit matcher;};
in {
  programs.claude-code.settings.hooks = {
    SessionStart = [(hook "off" null)];
    UserPromptSubmit = [(hook "busy" null)];
    PreToolUse = [(hook "busy" null)];
    PostToolUse = [(hook "busy" null)];
    Notification = [
      (hook "wait" "permission_prompt")
      (hook "wait" "elicitation_dialog")
      # Esc-interrupt fires no Stop; idle_prompt (~60s idle) clears a stuck spinner.
      (hook "done" "idle_prompt")
    ];
    Stop = [(hook "done" null)];
    StopFailure = [(hook "done" null)];
    SessionEnd = [(hook "off" null)];
  };

  programs.tmux.extraConfig = lib.mkAfter ''
    # Claude Code window names: state glyph + project dir (see claude-code/tmux.nix)
    # tmux re-evaluates this only on pane output; Claude's TUI redraws constantly, so that is enough.
    set -g automatic-rename-format "#{?@claude_state,#{?#{==:#{@claude_state},busy},#{@claude_spin},#{?#{==:#{@claude_state},wait},●,✓}} #{b:pane_current_path},#{?pane_in_mode,[tmux],#{pane_current_command}}#{?pane_dead,[dead],}}"
  '';
}
