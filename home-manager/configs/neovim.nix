{ pkgs, unstable,  ... }:

let
  repo = builtins.fetchGit {
      url = "https://github.com/ChristofferNissen/nvim-config";
      ref = "main";
      rev = "819d71fe78234a74b30da66fa41315d1930989bb";
  };
in
{
  home.packages = with unstable; [
    ripgrep
    fd
    lua-language-server
    yaml-language-server
    black
    gh
    wget
    luarocks
    biome
    shfmt
    gomodifytags
    impl
    # packer
    tectonic
    texliveSmall
    vimPlugins.luasnip
    mermaid-cli
    ghostscript
    marksman
    markdownlint-cli2
  ];

  programs.neovim = {
    package = unstable.neovim-unwrapped;
    enable = true;
    vimAlias = true;
    coc.enable = false;
    withNodeJs = true;
  };

  home.file = {
    "./.config/nvim/" = {
      # source = patchedRepo;
      source = repo;
      recursive = true;
    };
  };
}
