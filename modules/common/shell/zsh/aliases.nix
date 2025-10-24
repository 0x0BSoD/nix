{...}: {
  programs.zsh.shellAliases = {
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
    ctx = "kubectx";
    k = "kubecolor";
    kk = ''k get ns -o custom-columns=":metadata.name" | fzf --bind "enter:become(k9s -n {1} --headless --splashless -c pod)"'';

    # === Git ===
    ga = "git add -A";
    gp = "git push";
    gl = "git log";
    gs = "git status";
    gd = "git diff";
    gm = "git commit -m";
    gma = "git commit -am";
    gb = "git branch";
    gcb = "git branch | fzf --preview \"git show --color=always {-1}\" --bind \"enter:become(git checkout {-1})\" --height 40% --tmux --layout reverse";
    gc = "git checkout";
    gra = "git remote add";
    grr = "git remote rm";
    gpu = "git pull";
    gcl = "git clone";
    gta = "git tag -a -m";
    gf = "git reflog";
    gri = "git rebase -i";
  };
}
