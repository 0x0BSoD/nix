{
  lib,
  config,
  ...
}: {
  options.tools.develop.java.enable = lib.mkEnableOption "Java" // {default = true;};

  config = lib.mkIf config.tools.develop.java.enable {
    programs.java.enable = true;
  };
}
