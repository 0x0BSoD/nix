# Nord color theme for the Claude Code TUI (https://www.nordtheme.com/docs/colors-and-palettes).
# Claude Code loads ~/.claude/themes/<slug>.json; `theme = "custom:<slug>"` selects it.
_: let
  nord = {
    n0 = "#2E3440";
    n1 = "#3B4252";
    n2 = "#434C5E";
    n3 = "#4C566A";
    n4 = "#D8DEE9";
    n6 = "#ECEFF4";
    n7 = "#8FBCBB";
    n8 = "#88C0D0";
    n9 = "#81A1C1";
    n10 = "#5E81AC";
    n11 = "#BF616A";
    n12 = "#D08770";
    n13 = "#EBCB8B";
    n14 = "#A3BE8C";
    n15 = "#B48EAD";
  };
in {
  programs.claude-code.settings.theme = "custom:nord";

  home.file.".claude/themes/nord.json".text = builtins.toJSON {
    name = "Nord";
    base = "dark";
    overrides = with nord; {
      claude = n8;
      claudeShimmer = "#BAD7E2"; # shimmers: base color mixed 50% with nord6
      text = n4;
      inverseText = n0;
      inactive = "#7B88A1"; # nord3 brightened, readable as secondary text
      inactiveShimmer = n4;
      subtle = n3;
      suggestion = n8;
      permission = n9;
      permissionShimmer = "#B6C8DA";
      remember = n15;

      success = n14;
      error = n11;
      warning = n13;
      warningShimmer = "#EBDDBF";
      merged = n15;

      promptBorder = n3;
      promptBorderShimmer = n9;
      planMode = n7;
      autoAccept = n15;
      bashBorder = n12;
      ide = n9;
      fastMode = n12;
      fastModeShimmer = "#DEBBB2";

      # Diff backgrounds: nord14/nord11 blended onto nord0 (12% dimmed, 25% line, 45% word).
      diffAdded = "#4B5653";
      diffRemoved = "#523F4A";
      diffAddedDimmed = "#3C4449";
      diffRemovedDimmed = "#3F3945";
      diffAddedWord = "#627262";
      diffRemovedWord = "#6F4853";

      userMessageBackground = n1;
      userMessageBackgroundHover = n2;
      bashMessageBackgroundColor = n1;
      memoryBackgroundColor = n1;
      selectionBg = n3;
      composerSidebarBackground = n1;

      rate_limit_fill = n8;
      rate_limit_empty = n2;
      briefLabelYou = n9;
      briefLabelClaude = n8;

      red_FOR_SUBAGENTS_ONLY = n11;
      blue_FOR_SUBAGENTS_ONLY = n10;
      green_FOR_SUBAGENTS_ONLY = n14;
      yellow_FOR_SUBAGENTS_ONLY = n13;
      purple_FOR_SUBAGENTS_ONLY = n15;
      orange_FOR_SUBAGENTS_ONLY = n12;
      pink_FOR_SUBAGENTS_ONLY = "#D4A5C9";
      cyan_FOR_SUBAGENTS_ONLY = n8;
    };
  };
}
