# Third-party Claude Code plugins, pinned and loaded via `--plugin-dir` (no `/plugin install` needed).
# Their hooks call `node` from PATH (provided by the develop module).
{pkgs, ...}: {
  programs.claude-code.plugins = [
    # Ponytail: "lazy senior dev" mode — minimal code, YAGNI, stdlib first.
    (pkgs.fetchFromGitHub {
      owner = "DietrichGebert";
      repo = "ponytail";
      rev = "96608e078b2d5ea607c5c3b8b5a54d1c1fba6846"; # v5.3.3
      hash = "sha256-PhPtZbeX2wBp19GtWRy+fV93+fFYZe5S487eXPDl/us=";
    })
    # Caveman: terse caveman-speak output to cut tokens.
    (pkgs.fetchFromGitHub {
      owner = "JuliusBrussee";
      repo = "caveman";
      rev = "ad473752bdc86ca96d7289443228d4c53ec119a8"; # v4.1.0
      hash = "sha256-Of/urSM5WlXBg1gJzW4FgaMRRQBvX/VXJdc3w3jw0bg=";
    })
  ];
}
