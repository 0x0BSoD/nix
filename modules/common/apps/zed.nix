{ ... }:

{
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
      theme = {
        mode = "system";
        light = "Nord Light";
        dark = "Nord Dark";
      };
      minimap = {
        show = "auto";
      };
      inlay_hints = {
        enabled = true;
      };
      buffer_font_family = "JetBrains Mono";
      buffer_font_features = {
        calt = 1;
      };
      ui_font_family = "JetBrains Mono";
      telemetry = {
        diagnostics = false;
        metrics = false;
      };
      base_keymap = "JetBrains";
      vim_mode = true;
      ui_font_size = 14.0;
      buffer_font_size = 14.0;

      languages = {
        YAML = {
          formatter = "language_server";
        };
      };

      lsp = {
        jsonnet-language-server = {
          settings = {
            resolve_paths_with_tanka = true;
          };
        };
        gopls = { };
        yaml-language-server = {
          settings = {
            yaml = {
              schemas = {
                "/Users/aleksandr.simonov/Documents/Code/Shemes/crd/bitnami_redis/values.schema.json" =
                  "/Users/aleksandr.simonov/Projects/Exness/Platform/redis/services/**/*.yaml";
              };
            };
          };
        };
      };
    };
  };
}
