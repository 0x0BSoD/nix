{pkgs}:
with pkgs.vimPlugins; [
  nvim-treesitter.withAllGrammars
  nvim-lspconfig

  # editor
  telescope-nvim
  telescope-recent-files

  # ui
  nord-nvim
  bufferline-nvim
  lualine-nvim
  dressing-nvim

  # coding
  lspsaga-nvim
  nvim-cmp
  conform-nvim
]
