{...}: {
  programs.nixvim = {
    enable = true;
    colorschemes.nord.enable = true;

    plugins = {
      web-devicons.enable = true;
      lualine.enable = true;
      mini-animate.enable = true;
      telescope.enable = true;
      treesitter.enable = true;
    };

    clipboard = {
      register = "unnamedplus";
      providers = {
        wl-copy = {
          enable = true;
        };
      };
    };

    # Global variables (vim.g.*)
    globals = {
      mapleader = " ";
      maplocalleader = " ";

      # -- disable some default providers
      loaded_node_provider = 0;
      loaded_python3_provider = 0;
      loaded_perl_provider = 0;
      loaded_ruby_provider = 0;
    };

    # The configuration options, e.g. line numbers (vim.opt.*)
    opts = {
      showcmd = false;
      laststatus = 0;
      cmdheight = 0;
      showmode = false;

      cursorline = true;
      cursorlineopt = "number";

      expandtab = true;
      shiftwidth = 2;
      smartindent = true;
      tabstop = 2;
      softtabstop = 2;

      spell = false;
      fillchars.eob = " ";
      ignorecase = true;
      smartcase = true;
      mouse = "a";
      smoothscroll = true;

      number = true;
      numberwidth = 2;
      ruler = false;

      signcolumn = "yes";
      splitbelow = true;
      splitright = true;
      timeoutlen = 400;
      undofile = true;

      updatetime = 250;

      encoding = "utf-8";
      fileencoding = "utf-8";

      backup = false;
      swapfile = false;

      scrolloff = 10;
      wrap = false;

      autoindent = true;
      backspace = "indent,eol,start";

      termguicolors = true;
    };

    extraConfigLua = "
    vim.cmd([[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]])
    vim.cmd([[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]])
    vim.cmd([[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]])
    vim.cmd([[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]])
    vim.cmd([[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]])
    vim.cmd([[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]])
    vim.opt.wildignore = [[
    .git,.hg,.svn
    *.aux,*.out,*.toc
    *.o,*.obj,*.exe,*.dll,*.manifest,*.rbc,*.class
    *.ai,*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png,*.psd,*.webp
    *.avi,*.divx,*.mp4,*.webm,*.mov,*.m2ts,*.mkv,*.vob,*.mpg,*.mpeg
    *.mp3,*.oga,*.ogg,*.wav,*.flac
    *.eot,*.otf,*.ttf,*.woff
    *.doc,*.pdf,*.cbr,*.cbz
    *.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz,*.kgb
    *.swp,.lock,.DS_Store,._*
    */tmp/*,*.so,*.swp,*.zip,**/node_modules/**,**/target/**,**.terraform/**
    ]]
    ";
  };
}
