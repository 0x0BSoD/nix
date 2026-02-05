{pkgs, ...}: {
  home.packages = with pkgs; [
    zig
    zig-zlint
    zig-shell-completions
  ];
}
