{pkgs, ...}: {
  home.sessionVariables = {
    EDITOR = "nvim";
    PAGER = "";
    FZF_CTRL_R_OPTS = "
      --preview 'echo {}' --preview-window up:3:hidden:wrap
      --bind 'ctrl-/:toggle-preview'
      --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
      --color header:italic
      --header 'Press CTRL-Y to copy command into clipboard'";

    FZF_CTRL_T_OPTS = "
      --walker-skip .git,node_modules,target
      --preview 'bat -n --color=always {}'
      --bind 'ctrl-/:change-preview-window(down|hidden|)'";

    FZF_ALT_C_OPTS = "
      --walker-skip .git,node_modules,target
      --preview 'tree -C {}'";

    PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
  };
}
