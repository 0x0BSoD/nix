# Work-only Teleport tooling: tsh aliases, the tkube cluster switcher, and
# prompt styling for work cluster naming conventions. Kept out of shared
# modules so personal hosts don't carry work infrastructure config.
{...}: {
  programs.zsh.shellAliases = {
    tlt = "tsh login --proxy=teleport.test.env:443 teleport.test.env";
    tlp = "tsh login --proxy=teleport.prod.env:443 teleport.prod.env";
    tkl = "tsh kube login";
    tkls = "tsh kube ls";
    ktt = "tmux display-popup -EE -T kTool ktool -env test";
    ktp = "tmux display-popup -EE -T kTool ktool -env prod";
  };

  programs.zsh.initContent = builtins.readFile ./tkube.sh;

  programs.starship.settings.kubernetes.contexts = [
    {
      context_pattern = "^(.*)-prod(?:-env)?$";
      style = "green";
      symbol = "❗ ";
    }
    {
      context_pattern = "^(.*)-prod-trust(?:-env)?$";
      style = "green";
      symbol = "‼️ ";
    }
    {
      context_pattern = "^(.*)-test-trust(?:-env)?$";
      style = "green";
      symbol = "❕ ";
    }
  ];
}
