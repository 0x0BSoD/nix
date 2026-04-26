{pkgs, ...}: {
  programs.zed-editor = {
    enable = true;
    package = pkgs.zed-editor;

    extensions = [
      "basher"
      "catppuccin-icons"
      "codebook"
      "context7"
      "dockerfile"
      "helm"
      "jsonnet"
      "latex"
      "lua"
      "nix"
      "nord"
      "sql"
      "terraform"
      "toml"
      "zig"
      "qml"
    ];

    userSettings = {
      vim_mode = true;
      vim = {
        use_system_clipboard = "always";
      };
      vertical_scroll_margin = 20;

      base_keymap = "JetBrains";
      current_line_highlight = "all";
      preferred_line_length = 160;
      soft_wrap = "editor_width";

      telemetry = {
        diagnostics = false;
        metrics = false;
      };

      ## Fonts
      ui_font_size = 16.0;
      buffer_font_size = 16.0;
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

      tab_size = 4;
      tab_bar = {
        show_nav_history_buttons = false;
        show_tab_bar_buttons = false;
      };
      tabs = {
        git_status = true;
        file_icons = true;
        show_diagnostics = "errors";
      };

      active_pane_modifiers = {
        border_size = 0.0;
        inactive_opacity = 0.7;
      };

      relative_line_numbers = "wrapped";
      colorize_brackets = true;

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

      outline_panel = {
        dock = "right";
      };

      search = {
        button = false;
      };

      diagnostics = {
        button = true;
        inline = {
          enabled = true;
        };
      };

      git_panel = {
        collapse_untracked_diff = true;
        sort_by_path = true;
        fallback_branch_name = "master";
        button = true;
      };

      centered_layout = {
        left_padding = 0.15;
        right_padding = 0.15;
      };

      git = {
        inline_blame = {
          enabled = true;
          delay_ms = 500;
          min_column = 80;
        };
      };

      ## AI
      disable_ai = true;
      # features = {
      #   edit_prediction_provider = "copilot";
      # };
      # agent = {
      #   use_modifier_to_send = true;
      #   model_parameters = [];
      #   enable_feedback = false;
      #   default_model = {
      #     provider = "deepseek";
      #     model = "deepseek-chat";
      #   };
      # };

      ## ================
      completions = {
        lsp_fetch_timeout_ms = 15;
      };

      inlay_hints = {
        enabled = true;
        show_background = false;
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
        Rust = {
          format_on_save = "on";
          inlay_hints = {
            enabled = true;
          };
        };

        Go = {
          format_on_save = "on";
          formatter = "language_server";
          code_actions_on_format = {
            "source.organizeImports" = true;
          };
        };

        YAML = {
          formatter = "language_server";
          tab_size = 2;
        };

        Lua = {
          format_on_save = "on";
          formatter = {
            external = {
              command = "stylua";
              arguments = [
                "--syntax=Lua54"
                "--respect-ignores"
                "--stdin-filepath"
                "{buffer_path}"
                "-"
              ];
            };
          };
        };

        Nix = {
          language_servers = ["nixd" "!nil"];
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

        Markdown = {
          soft_wrap = "preferred_line_length";
          remove_trailing_whitespace_on_save = false;
        };

        LaTeX = {
          show_edit_predictions = false;
          soft_wrap = "preferred_line_length";
          preferred_line_length = 110;
        };

        QML = {
          formatter = {
            external = {
              command = "sh";
              arguments = [
                "-c"
                "tmp=$(mktemp --suffix .qml); cat > $tmp; qmlformat $tmp"
              ];
            };
          };
        };
      };

      ## ==================
      lsp = {
        rust-analyzer = {
          initialization_options = {
            checkOnSave = true;
          };
        };

        yaml-language-server = {
          settings = {
            yaml = {
              validate = true;
              hover = true;

              format = {
                enable = true;
              };

              schemaStore = {
                enable = true;
              };

              kubernetesCRDStore = {
                enable = true;
              };
            };
          };
        };

        jsonnet-language-server = {
          settings = {
            resolve_paths_with_tanka = true;
          };
        };

        lua_ls = {
          settings = {
            runtime = {
              version = "LuaJIT";
            };
            diagnostics = {
              globals = ["vim"];
            };
            telemetry = {
              enable = false;
            };
          };
        };

        gopls.initialization_options = {
          directoryFilters = [
            "-**/node_modules"
            "-**/.git"
            "-**/.idea"
          ];
          usePlaceholders = true;
          completeUnimported = true;
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
            gc_details = false;
            generate = true;
            regenerate_cgo = true;
            run_govulncheck = true;
            test = true;
            tidy = true;
            upgrade_dependency = true;
            vendor = true;
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
        nixd = {
          settings = {
            nixpkgs = {
              expr = "import (builtins.getFlake (builtins.toString ./.)).inputs.nixpkgs {}";
            };
          };
        };
        qml = {
          binary = {
            arguments = ["-E"];
          };
        };
      };
    };
  };
}
