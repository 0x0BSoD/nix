{...}: {
  programs.zsh = {
    enable = true;

    enableCompletion = false;

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    initContent = ''
      alias kubectl="kubecolor";
      alias k="kubecolor";
      alias ctx="kubectx";
      alias kk='k get ns -o custom-columns=":metadata.name" | fzf --bind "enter:become(k9s -n {1} --headless --splashless -c pod)"';

      autoload -Uz compinit
      if [[ "$(date +%j)" != "$(stat -f '%Sm' -t '%j' ''${ZDOTDIR:-$HOME}/.zcompdump 2>/dev/null)" ]]; then
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
        kubectl completion zsh 2> /dev/null >| "$ZSH_CACHE_DIR/completions/_kubectl" &|
      fi

      if (( ''${+_comps[kubectl]} )); then
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
        param=''${*: -1}
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
       secretData=''${*: -1}
       kubectlParams=''${*:1:-1}
       kubectl get secret "''${=kubectlParams}" -o "jsonpath={.data.$secretData}" | base64 -d}
    '';

    oh-my-zsh = {
      enable = true;
      extraConfig = ''
        DISABLE_UNTRACKED_FILES_DIRTY="true"
        COMPLETION_WAITING_DOTS=true
        zstyle ':omz:update' mode disabled # Disable auto update
      '';
      plugins = [
        "fzf"
      ];
    };

    setOptions = [
      "EXTENDED_HISTORY"
      "HIST_EXPIRE_DUPS_FIRST"
      "HIST_REDUCE_BLANKS"
      "HIST_IGNORE_DUPS"
      "HIST_IGNORE_SPACE"
      "HIST_VERIFY"
      "INC_APPEND_HISTORY"
      "SHARE_HISTORY"
      "NO_BEEP"
    ];
  };

  imports = [
    ./zoxide.nix
    ./starship.nix
  ];
}
