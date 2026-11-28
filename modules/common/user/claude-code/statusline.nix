# Status line: model, then usage bars for context window and the 5h / 7d rate limits.
# rate_limits is sent only for claude.ai subscriptions, after the first API response; missing bars are skipped.
{pkgs, ...}: let
  filter = pkgs.writeText "claude-statusline.jq" ''
    def color(c): "\u001b[38;2;\(c)m\(.)\u001b[0m";
    def rep(s; n): if n > 0 then s * n else "" end;
    def bar(name; fmt):
      if .used_percentage == null then empty else
        (.used_percentage | floor) as $p
        | ([($p / 10 | round), 10] | min) as $n
        # Nord red / yellow / green
        | (if $p >= 80 then "191;97;106" elif $p >= 50 then "235;203;139" else "163;190;140" end) as $c
        | "\(name) \(rep("█"; $n) | color($c))\(rep("░"; 10 - $n) | color("76;86;106")) \($p)%"
          + (if .resets_at then " " + ("↻\(.resets_at | strflocaltime(fmt))" | color("123;136;161")) else "" end)
      end;
    [
      (.model.display_name // empty | color("136;192;208")),
      (.context_window // {} | bar("ctx"; "")),
      (.rate_limits.five_hour // {} | bar("5h"; "%H:%M")),
      (.rate_limits.seven_day // {} | bar("7d"; "%a %H:%M"))
    ] | join("  ")
  '';
in {
  programs.claude-code.settings.statusLine = {
    type = "command";
    command = "${pkgs.jq}/bin/jq -rf ${filter}";
  };
}
