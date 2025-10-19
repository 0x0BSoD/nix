{...}: {
  programs.zsh = {
    enable = true;

    # enableCompletion = true;

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    plugins = [
    ];

    completionInit = ''
      autoload bashcompinit && bashcompinit
      complete -C '$(which aws_completer)' aws
      autoload -Uz compinit
      if [ "$(date +'%j')" != "$(stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)" ]; then
          compinit
      else
          compinit -C
      fi

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
    '';

    initContent = ''
      # Use this setting if you want to disable marking untracked files under VCS as dirty.
      # This makes repository status checks for large repositories much, much faster.
      DISABLE_UNTRACKED_FILES_DIRTY="true"
      COMPLETION_WAITING_DOTS=true

      setopt NO_BEEP # Don't beep on errors.

      # History
      HISTFILE="$HOME/.zsh_history"
      HISTIGNORE="&:exit:reset:clear:zh"
      setopt EXTENDED_HISTORY # Save each command's epoch timestamps and the duration in seconds.
      setopt HIST_EXPIRE_DUPS_FIRST # Expire duplicate entries first when trimming history.
      setopt HIST_REDUCE_BLANKS # Remove superfluous blanks before recording an entry.
      setopt HIST_IGNORE_DUPS # Don't record an entry that was just recorded again.
      setopt HIST_IGNORE_SPACE # Don't record an entry starting with a space.
      setopt HIST_VERIFY # Don't execute the line directly instead perform history expansion.
      setopt INC_APPEND_HISTORY # Write to the history file immediately, not when the shell exits.
      setopt SHARE_HISTORY # Share history between all sessions.

      export EDITOR="nvim"

      # fzf
      export FZF_CTRL_R_OPTS="
        --preview 'echo {}' --preview-window up:3:hidden:wrap
        --bind 'ctrl-/:toggle-preview'
        --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
        --color header:italic
        --header 'Press CTRL-Y to copy command into clipboard'"

      export FZF_CTRL_T_OPTS="
        --walker-skip .git,node_modules,target
        --preview 'bat -n --color=always {}'
        --bind 'ctrl-/:change-preview-window(down|hidden|)'"

      export FZF_ALT_C_OPTS="
        --walker-skip .git,node_modules,target
        --preview 'tree -C {}'"

      function kgn() {
        kubectl get nodes --no-headers -owide | awk '{if ($2 =="Ready") {print "✅ " $1 " " $3 " " $8"_"$9} else {print "❌ w" $1 " " $2 " " $3 " " $8"_"$9}}'
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
       kubectl get secret "''${=kubectlParams}" -o "jsonpath={.data.$secretData}" | base64 -d
      }
    '';
  };

  imports = [
    ./zoxide.nix
    ./starship.nix
  ];
}
