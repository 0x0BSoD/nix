alias kubectl="kubecolor";
alias k="kubecolor";
alias ctx="kubectx";
alias kk='k get ns -o custom-columns=":metadata.name" | fzf --bind "enter:become(k9s -n {1} --headless --splashless -c pod)"';

autoload -Uz compinit
if [[ "$(date +%j)" != "$(stat -f '%Sm' -t '%j' ${ZDOTDIR:-$HOME}/.zcompdump 2>/dev/null)" ]]; then
  compinit -i
else
  compinit -C -i
fi

autoload -U +X bashcompinit && bashcompinit

compdef kubecolor=kubectl
if [[ ! -f "$ZSH_CACHE_DIR/completions/_kubectl" ]]; then
  typeset -g -A _comps
  autoload -Uz _kubectl
  _comps[kubectl]=_kubectl
  kubectl completion zsh 2> /dev/null > "$ZSH_CACHE_DIR/completions/_kubectl" &
fi

if (( ${+_comps[kubectl]} )); then
  function kj() { kubectl "$@" -o json | jq; }
  function kjx() { kubectl "$@" -o json | fx; }
  function ky() { kubectl "$@" -o yaml | yh; }

  compdef k=kubectl
  compdef kj=kubectl
  compdef kjx=kubectl
  compdef ky=kubectl
fi

function kgn() {
  k get nodes --no-headers -owide | awk '{if ($2 =="Ready") {print "✅ " $1 " " $3 " " $8"_"$9} else {print "❌ w" $1 " " $2 " " $3 " " $8"_"$9}}'
}

function kp() {
  param=${*: -1}
  req=$(k get po -A --no-headers | fzf --height=80% --border=sharp --prompt="Pod > ")
  pod=$(echo "$req" | awk '{ print $2 }')
  ns=$(echo "$req" | awk '{ print $1 }')
  if [[ -n "$param" ]];then
    kubectl -n $ns get po $pod -oyaml | yq ".$param"
  else
    kubectl -n $ns get po $pod -oyaml | yq
  fi
}

function kd() {
  ns=$(kubectl get ns -o custom-columns=":metadata.name" | fzf --prompt="Namespace> ")
  [[ -z "$ns" ]] && return
  dep=$(kubectl -n "$ns" get deployments -o custom-columns=":metadata.name" --no-headers | fzf --prompt="Deployment> " \
    --preview="kubectl -n $ns get pods --selector app.kubernetes.io/name={1}" \
    --preview-window='45%,border-sharp')
  [[ -z "$dep" ]] && return
  selector=$(k -n "$ns" get deployments "$dep" -oyaml | yq '.spec.selector.matchLabels."app.kubernetes.io/name"')
  stern -n $ns --selector app.kubernetes.io/name=$selector
}

function kgsecd() {
 secretData=${*: -1}
 kubectlParams=${*:1:-1}
 kubectl get secret "${=kubectlParams}" -o "jsonpath={.data.$secretData}" | base64 -d
}

function tkube() {
  local sf script sel
  sf=$(mktemp /tmp/tkube.XXXX)
  script=$(mktemp /tmp/tkube.XXXX.sh)
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

  rm -f "$sf" "$script"
  [[ -n "$sel" ]] && tsh kube login "${sel%% *}"
}
