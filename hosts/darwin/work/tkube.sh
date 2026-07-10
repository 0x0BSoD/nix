function tkube() {
  local sf script sel
  sf=$(mktemp /tmp/tkube.XXXX)
  script=$(mktemp /tmp/tkube.XXXX.sh)
  trap 'rm -f "$sf" "$script"' EXIT INT TERM
  echo test > "$sf"

  cat > "$script" << SCRIPTEOF
#!/bin/bash
e=\$(cat "$sf")
[[ "\$e" == prod ]] && p="teleport.prod.env:443" || p="teleport.test.env:443"
tsh --proxy="\$p" kube ls 2>/dev/null | awk 'NR>2 && NF>0 && \$1!~/^-/{
  name=\$1; labels=\$2; env=""; team=""; dist=""
  n=split(labels,kv,",")
  for(i=1;i<=n;i++){split(kv[i],p,"="); if(p[1]=="env"||p[1]=="environment")env=p[2]; if(p[1]=="team")team=p[2]; if(p[1]=="distribution"||p[1]=="dist")dist=p[2]}
  printf "%s [%s] [%s] [%s]\n", name, env, team, dist
}'
SCRIPTEOF
  chmod +x "$script"

  sel=$(bash "$script" | fzf \
    --prompt="Kube> " \
    --header="Tab: test↔prod  Enter: login" \
    --layout=reverse \
    --bind "tab:execute-silent(if [[ \$(cat $sf) == test ]]; then echo prod > $sf; else echo test > $sf; fi)+reload(bash $script)")

  [[ -n "$sel" ]] && tsh kube login "${sel%% *}"
}
