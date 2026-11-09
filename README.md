# nix — Nix Config

Personal Nix configuration and NixOS/Home Manager setup for 0x0BSoD.

This repository contains declarative Nix configuration (flakes recommended) for managing machines, user environments, and development shells.

Hyprland is configured through Home Manager in `modules/linux/user/hyprland`.
It generates `~/.config/hypr/hyprland.lua`: compositor options live under
`settings.config`, while keybindings and session hooks use the Lua API in
`extraConfig`. Optional `monitors.lua` and `workspaces.lua` in the Hyprland
config directory are loaded when present; `nwg-displays` can manage these files.

Press **Super + Shift + Escape** to open the Rofi power menu (or run
`power-menu`). It offers Lock, Suspend, Logout, Reboot, and Power Off.
Logout, Reboot, and Power Off require confirmation; Escape cancels the menu.

After rebuilding with `sudo nixos-rebuild switch --flake .#tpad`, log out and
start a new Hyprland session to switch from the old configuration file to Lua.

Neovim is managed in `modules/common/user/neovim.nix` for Linux and macOS.
It preserves Nord and adds completion, signature help, language navigation,
formatting on save, a file tree, Git integration, diagnostics, and Markdown
preview. Language servers and formatters come from Nix; Mason is not required.
The older NvChad configuration remains untouched.

The leader key is **Space**. Press it and wait to see available shortcuts.

| Keys | Action |
| --- | --- |
| `Space e` | Toggle file explorer |
| `Space ff` / `Space fg` / `Space fb` | Find files / search project / buffers |
| `gd` / `gr` / `gi` / `gt` | Definition / references / implementation / type |
| `K` / `Space ch` | Documentation / signature help |
| `Space rn` / `Space ca` | Rename symbol / code action |
| `Space fs` / `Space fw` | Document / workspace symbols |
| `Space tt` / `Space td` | Project / buffer diagnostics |
| `[d` / `]d` / `Space cd` | Previous / next / line diagnostics |
| `Space cf` / `Space uf` | Format buffer / toggle formatting on save |
| `Space gs` / `Space gd` / `Space gc` | Git status / open diff / close diff |
| `Space gh` | Current file's Git history |
| `Space mp` | Toggle browser Markdown preview |
| `Ctrl h/j/k/l` | Move between windows |

Completion uses Blink's default keys: `Ctrl-Space` opens suggestions,
`Ctrl-n`/`Ctrl-p` selects, `Ctrl-y` accepts, and `Ctrl-e` dismisses.
Formatting on save is enabled by default; `:let b:disable_autoformat = v:true`
disables it for one buffer. Project language dependencies (for example Python
virtual environments, Go modules, or C/C++ compilation databases) still belong
to the project's environment. Run `nvim` from the project root or development
shell. Rebuild the relevant NixOS or nix-darwin host to activate the config.
