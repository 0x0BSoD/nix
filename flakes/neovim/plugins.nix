{pkgs}:
with pkgs.vimPlugins; [
  nvim-treesitter.withAllGrammars

  # editor
  telescope-nvim
  telescope-recent-files

  # ui
  nord-nvim
]
