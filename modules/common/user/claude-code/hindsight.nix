# Hindsight long-term memory for Claude Code (replaces `npx @vectorize-io/hindsight-coding-agents install claude-code`).
# The npm tarball ships a self-contained `dist/` bundle, so no node_modules are needed.
# Runtime state (server profile, banks, logs) stays mutable in ~/.hindsight.
{
  lib,
  pkgs,
  ...
}: let
  hindsight = pkgs.stdenvNoCC.mkDerivation rec {
    pname = "hindsight-coding-agents";
    version = "0.8.7";

    src = pkgs.fetchurl {
      url = "https://registry.npmjs.org/@vectorize-io/${pname}/-/${pname}-${version}.tgz";
      hash = "sha256-+a2LjH34w2PPBdu/11CJQkzNVKygz+4nrimOKKIXVn0=";
    };

    installPhase = ''
      mkdir -p $out
      cp -r . $out/
    '';
  };

  node = lib.getExe pkgs.nodejs;
  hook = name: timeout: [
    {
      hooks = [
        {
          type = "command";
          command = "${node} ${hindsight}/dist/${name}.js";
          inherit timeout;
        }
      ];
    }
  ];

in {
  programs.claude-code = {
    settings.hooks = {
      SessionStart = hook "claude-sessionstart-hook" 30;
      UserPromptSubmit = hook "claude-hook" 30;
      Stop = hook "claude-stop-hook" 60;
    };

    mcpServers.hindsight = {
      type = "stdio";
      command = node;
      args = ["${hindsight}/dist/mcp-server.js"];
      env.HINDSIGHT_MCP_HARNESS = "claude-code";
    };

    skills.hindsight-coding-agent = "${hindsight}/skill";
  };
}
