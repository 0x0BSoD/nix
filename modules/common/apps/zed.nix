{...}: {
  programs.zed-editor = {
    enable = true;

    extensions = [
      "basher"
      "dockerfile"
      "helm"
      "jsonnet"
      "nix"
      "nord-theme"
      "catppuccin-icons"
      "terraform"
      "toml"
      "zig"
      "codebook"
      "context7"
    ];

    userSettings = {
      vim_mode = true;
      vim = {
        use_system_clipboard = "always";
      };

      disable_ai = true;
      base_keymap = "JetBrains";
      current_line_highlight = "all";
      soft_wrap = "editor_width";
      telemetry = {
        diagnostics = false;
        metrics = false;
      };

      ## Fonts
      ui_font_size = 14.0;
      buffer_font_size = 14.0;
      buffer_font_family = "JetBrains Mono";
      buffer_font_features = {
        calt = 1;
      };
      ui_font_family = "JetBrains Mono";

      ## Apperance
      title_bar = {
        show_menus = false;
        show_sign_in = false;
        show_user_picture = true;
        show_onboarding_banner = false;
        show_branch_icon = true;
        show_branch_name = true;
      };
      relative_line_numbers = "wrapped";
      indent_guides = {
        enabled = true;
        coloring = "fixed";
      };
      icon_theme = "Catppuccin Frappé";
      theme = {
        mode = "system";
        light = "Nord Dark";
        dark = "Nord Dark";
      };
      minimap = {
        show = "auto";
      };
      toolbar = {
        breadcrumbs = true;
        quick_actions = false;
        selections_menu = false;
      };
      collaboration_panel = {
        button = false;
      };
      notification_panel = {
        button = false;
      };
      search = {
        button = false;
      };
      tab_bar = {
        show_nav_history_buttons = false;
        show_tab_bar_buttons = false;
      };
      git_panel = {
        collapse_untracked_diff = true;
        sort_by_path = true;
        fallback_branch_name = "master";
        button = true;
      };
      tabs = {
        git_status = true;
        file_icons = true;
        show_diagnostics = "errors";
      };
      centered_layout = {
        left_padding = 0.15;
        right_padding = 0.15;
      };

      ## ==================
      git = {
        inline_blame = {
          enabled = true;
          delay_ms = 500;
          min_column = 80;
        };
      };

      inlay_hints = {
        enabled = true;
      };

      terminal = {
        env = {
          EDITOR = "zed --wait";
        };
      };

      file_types = {
        Helm = [
          "**/templates/**/*.tpl"
          "**/templates/**/*.yaml"
          "**/templates/**/*.yml"
          "**/helmfile.d/**/*.yaml"
          "**/helmfile.d/**/*.yml"
          "**/values*.yaml"
        ];
        Dockerfile = [
          "Dockerfile"
          "Dockerfile.*"
        ];
        JSON = [
          "json"
          "jsonc"
          "*.code-snippets"
        ];
      };

      file_scan_exclusions = [
        "**/.git"
        "**/.svn"
        "**/.hg"
        "**/CVS"
        "**/.DS_Store"
        "**/Thumbs.db"
        "**/.classpath"
        "**/.settings"
        "**/out"
        "**/dist"
        "**/.husky"
        "**/.turbo"
        "**/.vscode-test"
        "**/.vscode"
        "**/.next"
        "**/.storybook"
        "**/.tap"
        "**/.nyc_output"
        "**/report"
        "**/node_modules"
      ];

      languages = {
        Go = {
          format_on_save = "on";
          formatter = "language_server";
          code_actions_on_format = {
            "source.organizeImports" = true;
          };
        };
        YAML = {
          formatter = "language_server";
        };
        Nix = {
          formatter = {
            external = {
              command = "alejandra";
              arguments = ["--quiet" "--"];
            };
          };
        };
        Python = {
          formatter = {
            language_server = {
              name = "ruff";
            };
          };
          language_servers = [
            "pyright"
            "ruff"
          ];
        };
      };

      ## ==================
      lsp = {
        yamlls = {
        };
        jsonnet-language-server = {
          settings = {
            resolve_paths_with_tanka = true;
          };
        };

        gopls.initialization_options = {
          directoryFilters = [
            "-**/node_modules"
            "-**/.git"
          ];
          gofumpt = true;
          symbolScope = "workspace";
          staticcheck = true;
          templateExtensions = ["tmpl"];
          experimentalPostfixCompletions = true;
          analyses = {
            nilness = true;
            unusedparams = true;
            unusedvariable = true;
            unusedwrite = true;
            useany = true;
          };
          codelenses = {
            gc_details = true;
          };
          hints = {
            assignVariableTypes = true;
            compositeLiteralFields = true;
            compositeLiteralTypes = true;
            constantValues = true;
            functionTypeParameters = true;
            parameterNames = true;
            rangeVariableTypes = true;
          };
        };
      };
    };
  };
}
