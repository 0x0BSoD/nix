# Third-party Claude Code plugins, pinned and loaded via `--plugin-dir` (no `/plugin install` needed).
# Their hooks call `node` from PATH (provided by the develop module).
{pkgs, ...}: {
  # Private marketplace over SSH; bump `rev` to update.
  programs.claude-code.marketplaces.agents-marketplace = builtins.fetchGit {
    url = "git@git.exness.io:platform-private/agents-marketplace.git";
    rev = "2c64f12eefd9e8cd4a259b19a64c0f6c20c1f8dc";
  };

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
    # diagram-design: diagrams as self-contained HTML/SVG.
    (pkgs.fetchFromGitHub {
      owner = "cathrynlavery";
      repo = "diagram-design";
      rev = "795eec47fd376e5dda0b9e056a49520060cd2f13"; # v2.6.181
      hash = "sha256-C0L3iyMYOkTk39yPslIkwkUTCKx8Y7KM89oitHGp2PA=";
    })
  ];
}
