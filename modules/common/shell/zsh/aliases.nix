{ ... }:

{
  programs.zsh.shellAliases = {
    # === Rename existing tools ===
    _cat = "which cat";
    _curl = "which curl";
    _ls = "/bin/ls";
    _watch = "which watch";
    _grep = "/bin/grep";
    _diff = "/usr/bin/diff";
    _du = "which du";
    _df = "which df";
    _top = "which top";
    _ps = "/bin/ps";
    _dig = "which dig";
    _cd = "which cd";
    _rm = "which rm";

    # === Core Shortcuts ===
    mkdir = "mkdir -p";
    c = "clear";
    rd = "rmdir";

    # === Utils and Apps ===
    cat = "bat -p --theme=Nord";
    cd = "z";
    curl = "curlie";
    grep = "rg";
    diff = "delta";
    du = "dust";
    df = "duf -hide special";
    find = "fd";
    top = "btm";
    ps = "procs";
    dig = "dog";
    watch = "viddy";
    tmp = "cd $(mktemp -d)";

    vim = "nvim";
    v = "nvim $(fzf -e)";

    # === ls ===
    ls = "lsd -Fh --color=auto --group-directories-first";
    ll = "lsd -Fhl --color=auto --group-directories-first";
    la = "lsd -Fhlal --color=auto --group-directories-first";
    li = "lsd -Fhial --color=auto --group-directories-first";
    lsa = "lsd -Fhld --color=auto .* --group-directories-first";

    # === Teleport ===
    tlt = "tsh login --proxy=teleport.test.env:443 teleport.test.env";
    tlp = "tsh login --proxy=teleport.prod.env:443 teleport.prod.env";

    # === Kubelet ===
    k = "kubecolor";
    kk = ''k get ns -o custom-columns=":metadata.name" | fzf --bind "enter:become(k9s -n {1} --headless --splashless -c pod)"'';
  };
}
