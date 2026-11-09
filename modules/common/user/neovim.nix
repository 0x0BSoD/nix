{
  config,
  pkgs,
  ...
}: {
  programs.nixvim = {
    enable = true;
    colorschemes.nord.enable = true;

    plugins = {
      # Language tools are installed by Nix, without Mason downloads.
      lsp = {
        enable = true;
        servers = {
          bashls.enable = true;
          clangd.enable = true;
          cmake.enable = true;
          dockerls.enable = true;
          gopls = {
            enable = true;
            settings.gopls = {
              completeUnimported = true;
              usePlaceholders = true;
              analyses.unusedparams = true;
              staticcheck = true;
            };
          };
          helm_ls.enable = true;
          lua_ls = {
            enable = true;
            settings.Lua.diagnostics.globals = ["vim"];
          };
          marksman.enable = true;
          nil_ls.enable = true;
          pyright.enable = true;
          ruff.enable = true;
          taplo.enable = true;
          vimls.enable = true;
          yamlls = {
            enable = true;
            # Let schemas match filenames; do not classify all YAML as Kubernetes.
            settings.yaml = {
              format.enable = false;
              schemaStore.enable = true;
            };
          };
        };
        keymaps = {
          silent = true;
          lspBuf = {
            gd = "definition";
            gD = "declaration";
            gi = "implementation";
            gt = "type_definition";
            K = "hover";
            "<leader>rn" = "rename";
            "<leader>ca" = "code_action";
            "<leader>ch" = "signature_help";
          };
        };
      };
      blink-cmp = {
        enable = true;
        settings = {
          keymap.preset = "default";
          completion.documentation.auto_show = true;
          signature.enabled = true;
        };
      };
      conform-nvim = {
        enable = true;
        settings = {
          format_on_save.__raw = ''
            function(bufnr)
              if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                return
              end
              return { timeout_ms = 1000, lsp_format = "fallback" }
            end
          '';
          formatters_by_ft = {
            nix = ["alejandra"];
            lua = ["stylua"];
            go = ["goimports" "gofumpt"];
            python = ["ruff_format"];
            sh = ["shfmt"];
            bash = ["shfmt"];
            json = ["prettier"];
            jsonc = ["prettier"];
            yaml = ["prettier"];
            markdown = ["prettier"];
            c = ["clang_format"];
            cpp = ["clang_format"];
          };
        };
      };
      nvim-tree = {
        enable = true;
        settings = {
          git.enable = true;
          renderer.highlight_git = true;
          update_focused_file.enable = true;
        };
      };
      gitsigns.enable = true;
      fugitive.enable = true;
      diffview.enable = true;
      trouble.enable = true;
      which-key.enable = true;
      nvim-autopairs.enable = true;
      comment.enable = true;
      markdown-preview.enable = true;
      dressing.enable = true;
      lualine.enable = true;
      mini-animate.enable = true;
      noice.enable = true;
      telescope.enable = true;
      treesitter = {
        enable = true;
        highlight.enable = true;
        indent.enable = true;
        # Keep parsers and queries matched to Nixvim's Treesitter package.
        grammarPackages = with config.programs.nixvim.plugins.treesitter.package.builtGrammars; [
          bash
          c
          cpp
          cmake
          dockerfile
          go
          gomod
          gowork
          gotmpl
          helm
          json
          lua
          markdown
          markdown_inline
          nix
          python
          regex
          toml
          vim
          vimdoc
          yaml
        ];
      };
      web-devicons.enable = true;
    };

    extraPlugins = [pkgs.vimPlugins.vim-helm];

    extraPackages = with pkgs; [
      ripgrep
      fd
      git
      alejandra
      stylua
      gofumpt
      gotools
      ruff
      shfmt
      prettier
      clang-tools
      shellcheck
    ];

    # Space is the leader. Descriptions are displayed by which-key.
    keymaps = let
      map = key: action: desc: {
        mode = "n";
        inherit key action;
        options = {
          silent = true;
          inherit desc;
        };
      };
    in [
      (map "<leader>e" "<cmd>NvimTreeToggle<CR>" "File explorer")
      (map "<leader>ff" "<cmd>Telescope find_files<CR>" "Find files")
      (map "<leader>fg" "<cmd>Telescope live_grep<CR>" "Search project")
      (map "<leader>fb" "<cmd>Telescope buffers<CR>" "Find buffers")
      (map "<leader>fh" "<cmd>Telescope help_tags<CR>" "Search help")
      (map "<leader>fs" "<cmd>Telescope lsp_document_symbols<CR>" "Document symbols")
      (map "<leader>fw" "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>" "Workspace symbols")
      (map "gr" "<cmd>Telescope lsp_references<CR>" "References")
      (map "<leader>tt" "<cmd>Trouble diagnostics toggle<CR>" "Project diagnostics")
      (map "<leader>td" "<cmd>Trouble diagnostics toggle filter.buf=0<CR>" "Buffer diagnostics")
      (map "<leader>gs" "<cmd>Git<CR>" "Git status")
      (map "<leader>gd" "<cmd>DiffviewOpen<CR>" "Git diff")
      (map "<leader>gc" "<cmd>DiffviewClose<CR>" "Close Git diff")
      (map "<leader>gh" "<cmd>DiffviewFileHistory %<CR>" "File history")
      (map "<leader>mp" "<cmd>MarkdownPreviewToggle<CR>" "Markdown preview")
      (map "<leader>cf" "<cmd>lua require('conform').format({ lsp_format = 'fallback' })<CR>" "Format buffer")
      (map "<leader>uf" "<cmd>lua vim.g.disable_autoformat = not vim.g.disable_autoformat; vim.notify('Format on save: ' .. tostring(not vim.g.disable_autoformat))<CR>" "Toggle format on save")
      (map "<leader>cd" "<cmd>lua vim.diagnostic.open_float()<CR>" "Line diagnostics")
      (map "[d" "<cmd>lua vim.diagnostic.jump({ count = -1, float = true })<CR>" "Previous diagnostic")
      (map "]d" "<cmd>lua vim.diagnostic.jump({ count = 1, float = true })<CR>" "Next diagnostic")
      (map "<Esc>" "<cmd>nohlsearch<CR>" "Clear search highlight")
      (map "<C-h>" "<C-w>h" "Left window")
      (map "<C-j>" "<C-w>j" "Lower window")
      (map "<C-k>" "<C-w>k" "Upper window")
      (map "<C-l>" "<C-w>l" "Right window")
    ];

    clipboard = {
      register = "unnamedplus";
      # providers = {
      #   wl-copy = {
      #     enable = true;
      #   };
      # };
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
      laststatus = 3;
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

    extraConfigLua = ''
      vim.diagnostic.config({ severity_sort = true, float = { border = "rounded" } })
    '';
  };
}
