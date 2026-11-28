{...}: {
  programs.zsh.shellAliases = {
    # === Core Shortcuts ===
    c = "clear";
    mkdir = "mkdir -p";
    rd = "rmdir";

    # === Utils and Apps ===
    cat = "bat -p";
    cd = "z";
    claude = "claude --model sonnet --advisor opus";
    curl = "curlie";
    df = "duf -hide special";
    diff = "delta";
    du = "dust";
    find = "fd";
    grep = "rg";
    ps = "procs";
    tmp = "cd $(mktemp -d)";
    top = "btm";
    watch = "viddy";

    vim = "nvim";
    v = "nvim $(fzf -e)";

    # === ls ===
    la = "lsd -Fhlal --color=auto --group-directories-first";
    li = "lsd -Fhial --color=auto --group-directories-first";
    ll = "lsd -Fhl --color=auto --group-directories-first";
    ls = "lsd -Fh --color=auto --group-directories-first";
    lsa = "lsd -Fhld --color=auto .* --group-directories-first";

    # === Git ===
    ga = "git add -A";
    gb = "git branch";
    gc = "git checkout";
    gcb = "git branch | fzf --preview \"git show --color=always {-1}\" --bind \"enter:become(git checkout {-1})\" --height 40% --tmux --layout reverse";
    gcl = "git clone";
    gd = "git diff";
    gf = "git reflog";
    gl = "git log";
    gm = "git commit -m";
    gma = "git commit -am";
    gp = "git push";
    gpu = "git pull";
    gra = "git remote add";
    gri = "git rebase -i";
    grr = "git remote rm";
    gs = "git status";
    gta = "git tag -a -m";

    # === Nix ===
    dflrebuild = "sudo darwin-rebuild switch --local --verbose --flake";
    dfrebuild = "sudo darwin-rebuild switch --verbose --flake";
    nixarch = "sudo nix flake archive";
    nixgc = "sudo nix-collect-garbage";
    nixup = "bash ${./nixup.sh}";
    osrebuild = "nh os switch";
  };
}
