{...}: {
  programs.zed-editor = {
    enable = true;

    extensions = [
      "nix"
      "toml"
      "terraform"
      "dockerfile"
      "zig"
      "nord-theme"
      "basher"
      "jsonnet"
    ];

    userSettings = {
      disable_ai = true;
      base_keymap = "JetBrains";
      vim_mode = true;
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
      indent_guides = {
        enabled = true;
        coloring = "indent_aware";
      };
      theme = {
        mode = "system";
        light = "Nord Light";
        dark = "Nord Dark";
      };
      minimap = {
        show = "auto";
      };

      ## ==================
      inlay_hints = {
        enabled = true;
      };

      terminal = {
        env = {
          EDITOR = "zed --wait";
        };
      };

      file_types = {
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

        yaml-language-server = {
          settings = {
            yaml = {
              schemas = {
                "/Users/aleksandr.simonov/Documents/Code/Shemes/crd/bitnami_redis/values.schema.json" = "/Users/aleksandr.simonov/Projects/Exness/Platform/redis/services/**/*.yaml";
              };
            };
          };
        };
      };
    };
  };
}
