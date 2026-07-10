alias kubectl="kubecolor";
alias k="kubecolor";
alias ctx="kubectx";
alias kk='k get ns -o custom-columns=":metadata.name" | fzf --bind "enter:become(k9s -n {1} --headless --splashless -c pod)"';

autoload -Uz compinit
# Fast path when the dump was refreshed in the last 24h; zsh glob qualifiers
# instead of stat(1), whose flags differ between BSD/macOS and GNU.
() {
  setopt local_options extended_glob
  if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh-24) ]]; then
    compinit -C -i
  else
    compinit -i
  fi
}

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
