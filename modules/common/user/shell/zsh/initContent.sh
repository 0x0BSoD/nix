alias kubectl='kubecolor';
alias k='kubecolor';
alias kk='k get ns -o custom-columns=":metadata.name" | fzf --bind "enter:become(k9s -n {1} --headless --splashless -c pod)"';

# context / namespace
alias ctx='kubectx';
alias kctx='kubectl config use-context'
alias kns='kubectl config set-context --current --namespace'
alias kwho='kubectl config view --minify -o jsonpath="{.current-context}/{..namespace}{\"\n\"}"'

# get
alias kg='kubectl get'
alias kgp='kubectl get pods -o wide'
alias kga='kubectl get all'
# alias kgn='kubectl get nodes -o wide'
alias kgpa='kubectl get pods -A -o wide'
alias kgy='kubectl get -o yaml'
alias kge='kubectl get events --sort-by=.lastTimestamp'

# "what's broken"
alias kbad='kubectl get pods -A --field-selector=status.phase!=Running,status.phase!=Succeeded'
alias krestarts='kubectl get pods -A --sort-by=".status.containerStatuses[0].restartCount" | tail -20'
alias knotready='kubectl get nodes | grep -v " Ready"'
alias kwarn='kubectl get events -A --field-selector type=Warning --sort-by=.lastTimestamp'
alias kimg='kubectl get pods -A -o jsonpath="{range .items[*]}{.metadata.namespace}/{.metadata.name}: {.spec.containers[*].image}{\"\n\"}{end}"'

# inspect / logs
alias kd='kubectl describe'
alias kl='kubectl logs -f --tail=100'
alias klp='kubectl logs --previous'
alias kla='kubectl logs -f --all-containers --prefix --tail=50'

# exec / debug
alias kex='kubectl exec -it'
alias kdbg='kubectl run dbg --rm -it --image=nicolaka/netshoot --restart=Never --'
alias knd='kubectl debug node/$1 -it --image=nicolaka/netshoot'   # better as a function, see below
alias kpf='kubectl port-forward'

# mutate
alias ka='kubectl apply -f'
alias kdel='kubectl delete'
alias kdelf='kubectl delete --force --grace-period=0'
alias kroll='kubectl rollout restart'
alias kstat='kubectl rollout status'
alias kscale='kubectl scale --replicas'

# dry-run generators
alias kdry='kubectl --dry-run=client -o yaml'
# usage: kdry create deploy web --image=nginx > web.yaml

# RBAC / resources
alias kcani='kubectl auth can-i --list'
alias ktop='kubectl top pods --sort-by=memory'
alias ktopn='kubectl top nodes'
alias kapi='kubectl api-resources --verbs=list --namespaced -o name'

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
  k get nodes --no-headers -owide | awk '{if ($2 =="Ready") {print "✅ " $1 " " $3 " " $8"_"$9} else {print "❌ " $1 " " $2 " " $3 " " $8"_"$9}}'
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

# function kgsecd() {
#  secretData=${*: -1}
#  kubectlParams=${*:1:-1}
#  kubectl get secret "${=kubectlParams}" -o "jsonpath={.data.$secretData}" | base64 -d
# }

# shell into a node via debug pod
knode() { kubectl debug node/"$1" -it --image=nicolaka/netshoot -- chroot /host; }

# all pods on a node
kpon() { kubectl get pods -A -o wide --field-selector spec.nodeName="$1"; }

# decode a secret
ksec() { kubectl get secret "$1" -o json | jq '.data | map_values(@base64d)'; }

# fzf pod picker -> logs / exec
klf() { kubectl get pods --no-headers | fzf | awk '{print $1}' | xargs -o kubectl logs -f --tail=100; }
kef() { kubectl get pods --no-headers | fzf | awk '{print $1}' | xargs -o -I{} kubectl exec -it {} -- sh; }

# dump every resource in a namespace (for diffing / backup)
kdump() { for r in $(kubectl api-resources --verbs=list --namespaced -o name); do kubectl get "$r" -n "${1:-default}" -o yaml 2>/dev/null; done; }

# force-remove a stuck finalizer
kunstick() { kubectl patch "$@" --type=merge -p '{"metadata":{"finalizers":null}}'; }
