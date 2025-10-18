{ ... }:

{
  programs.zed-editor = {
    enable = true;

    extensions = [
      "nix"
      "toml"
      "terraform"
    ];

    theme = {
      name = "one";
      appearance = "dark";
    };

    userSettings = { };
  };
}
