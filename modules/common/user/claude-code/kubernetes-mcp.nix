# Kubernetes MCP server (https://github.com/containers/kubernetes-mcp-server), built from source
# instead of `npx kubernetes-mcp-server@latest`. Not packaged in nixpkgs.
# Runtime flags are gone upstream; all settings live in the TOML config.
{
  config,
  lib,
  pkgs,
  ...
}: let
  kubernetes-mcp-server = pkgs.buildGoModule rec {
    pname = "kubernetes-mcp-server";
    version = "0.1.2";

    src = pkgs.fetchFromGitHub {
      owner = "containers";
      repo = "kubernetes-mcp-server";
      rev = "v${version}";
      hash = "sha256-7BoixYxAhC9/rv+L1QRGdtqoYNUxyuAsWwbaSpqzoFY=";
    };
    vendorHash = "sha256-B8Mb0nyflZwQK1UxOlPwTxX2FjwVMM5RiAPJughaOWw=";

    subPackages = ["cmd/kubernetes-mcp-server"];
    ldflags = let
      p = "github.com/containers/kubernetes-mcp-server/pkg/version";
    in [
      "-s"
      "-w"
      "-X ${p}.Version=v${version}"
      "-X ${p}.BinaryName=${pname}"
    ];
    doCheck = false; # tests need a live cluster (envtest)

    meta.mainProgram = pname;
  };

  configFile = "${config.xdg.configHome}/kubernetes-mcp-server.toml";
in {
  # Best-effort guardrail only: hides non-read-only tools; real limits come from cluster RBAC.
  # kubeconfig unset -> falls back to $KUBECONFIG / ~/.kube/config.
  xdg.configFile."kubernetes-mcp-server.toml".text = ''
    read_only = true
  '';

  programs.claude-code.mcpServers.kubernetes = {
    type = "stdio";
    command = lib.getExe kubernetes-mcp-server;
    args = ["--config" configFile];
  };
}
