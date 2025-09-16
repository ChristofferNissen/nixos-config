{ unstable, ... }:

let
  repo = builtins.fetchGit {
    url = "https://github.com/ChristofferNissen/nvim-config";
    ref = "main";
    rev = "f66702ab9a34866cc2dbae89d310e25929ec2cf6";
  };
in
{
  home.packages = (with unstable; [
    tree-sitter
    ripgrep
    fd
    wget
    luarocks
    biome
    tectonic
    texliveSmall
    mermaid-cli
    ghostscript
    python312Packages.pylatexenc
    nixd
    nodejs_22
    php84Packages.composer
    jdk21
    kotlin
    gradle
    php
    luajit
    julia-bin
    mercurial
  ]);

  programs.neovim = {
    package = unstable.neovim-unwrapped;
    enable = true;
    vimAlias = true;
    extraLuaPackages = ps: [ ps.jsregexp ps.tiktoken_core ps.luasql-sqlite3 ];
  };

  home.file = {
    "./.config/nvim/" = {
      source = repo;
      recursive = true;
    };
  };
}
