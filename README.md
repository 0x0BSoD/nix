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
