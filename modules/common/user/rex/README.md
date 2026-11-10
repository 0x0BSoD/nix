# Rex

Home Manager installs `init.lua` as `~/.config/rex/init.lua`. These bindings
use Rex directly; they do not start or require tmux.

The prefix is Ctrl+B, as in `../shell/tmux/tmux.conf`:

| Keys | Action |
| --- | --- |
| Alt+1–9 or prefix, 1–9 | Select tab |
| prefix, c / n | New / next tab |
| prefix, r / Shift+R | Rename tab / session |
| prefix, \| / _ | Split right / down |
| prefix, h/j/k/l or arrow | Focus adjacent pane |
| prefix, z | Toggle pane zoom |
| prefix, x / Shift+X | Close pane / tab |
| prefix, p | Paste system clipboard |
| Alt+PageUp / Alt+PageDown | Scroll one page |
| prefix, Ctrl+R | Reload Rex configuration |
| prefix, Ctrl+B | Send Ctrl+B to the terminal |

Bare Ctrl+H/J/K/L remain available to terminal programs. The tmux config's
conditional Neovim navigation is not reproduced: the documented Rex process
API does not specify the response fields needed to identify Neovim safely.

The current Rex action reference has no equivalent for tmux's vi copy mode,
buffer history/picker, detach/merge, activity/silence toggles, or status bar
and Spotify integration. The `tkube` popup is not ported. Confirmed destructive
shortcuts (kill other tabs/session) are omitted because no confirmation action
is documented. Clipboard paste replaces tmux's internal paste buffer.

Appearance, shell, scrollback, and tab behavior are Rex app settings rather
than settings exposed by the documented Lua configuration API. Working-directory
inheritance for new tabs/splits has not been verified.

After rebuilding, run `rex config check` and reload with prefix, Ctrl+R.
Reference: https://www.superlogical.com/rex/docs/reference/mac-actions
