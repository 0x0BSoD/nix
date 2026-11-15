{...}: {
  programs.starship = {
    enable = true;
    settings = {
      format = "\$status\$hostname\$directory\$git_branch\$git_commit\$git_state\$git_status\$kubernetes\$helm\$golang\$nodejs\$terraform\$package\$python\$line_break\$jobs\$character";

      # Nord palette, same as tmux: blue #81A1C1, cyan #88C0D0, purple #B48EAD,
      # yellow #EBCB8B, green #A3BE8C, red #BF616A, dim #4C566A

      directory = {
        truncation_length = 4;
        truncation_symbol = "…/";
        style = "bold fg:#81A1C1";
        read_only = " 󰌾";
        read_only_style = "fg:#BF616A";
        format = "[ $path]($style)[$read_only]($read_only_style) ";
      };

      git_branch = {
        symbol = " ";
        style = "fg:#B48EAD";
        format = "[$symbol$branch]($style) ";
      };
      git_commit = {
        only_detached = true;
        style = "fg:#EBCB8B";
      };
      git_status = {
        format = "($all_status$ahead_behind) ";
        up_to_date = "[✓](fg:#A3BE8C)";
        modified = "[!](bold fg:#EBCB8B)";
        untracked = "[?](bold fg:#88C0D0)";
        staged = "[+($count)](fg:#A3BE8C)";
        ahead = "[⇡$count](fg:#88C0D0)";
        behind = "[⇣$count](fg:#EBCB8B)";
        diverged = "[⇕⇡$ahead_count⇣$behind_count](fg:#BF616A)";
      };

      kubernetes = {
        symbol = "󱃾 ";
        style = "fg:#88C0D0";
        format = "[$symbol$context]($style) ";
        disabled = false;
      };

      package = {
        symbol = "󰏗 ";
        style = "fg:#4C566A";
        format = "[$symbol$version]($style) ";
      };

      jobs = {
        number_threshold = 1;
        style = "fg:#EBCB8B";
        format = "[󰜎 $number]($style) ";
      };

      character = {
        success_symbol = "[❯](bold fg:#88C0D0)";
        error_symbol = "[❯](bold fg:#BF616A)";
      };
    };
  };
}
