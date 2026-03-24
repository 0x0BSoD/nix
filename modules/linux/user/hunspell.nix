{pkgs, ...}: {
  home.packages = (
    with pkgs; [
      hunspell
      hunspellDicts.ru_RU
      hunspellDicts.en_US
    ]
  );
}
