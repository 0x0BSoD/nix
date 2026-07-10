{...}: {
  programs.starship = {
    enable = true;
    settings = {
      format = "\$status\$hostname\$directory\$git_branch\$git_commit\$git_state\$git_status\$kubernetes\$helm\$golang\$nodejs\$terraform\$package\$python\$line_break\$jobs\$character";

      directory = {
        truncation_length = 8;
        truncation_symbol = "…/";
        format = "┏ [$path]($style)[$read_only]($read_only_style) ";
      };

      git_branch = {
        format = "⎮ [$symbol$branch]($style) ";
        symbol = "🌱 ";
      };
      git_commit = {
        only_detached = true;
      };
      git_status = {
        format = "($all_status$ahead_behind) ";
        up_to_date = "[✓](green)";
        modified = "[!](bold fg:208)";
        untracked = "[?](bold fg:75)";
        staged = "[++($count)](green)";
      };

      kubernetes = {
        symbol = "⛵ ";
        format = "| [$symbol$context]($style) ";
        disabled = false;
      };

      package = {
        symbol = "📦";
        format = "⎮ [$symbol$version]($style) ";
      };

      jobs = {
        number_threshold = 1;
        format = "┣ [$symbol $number background jobs\n]($style)";
      };

      character = {
        success_symbol = "┗ [✨](yellow)";
        error_symbol = "┗ [✗](fg:204)";
      };
    };
  };
}
