{ unstable, ... }:

let
  repo = builtins.fetchGit {
    url = "https://github.com/ChristofferNissen/nvim-config";
    ref = "main";
    rev = "fa80c1251bf7c83d3ba6a92f01d4f40c3a373b88";
  };
in
{
  home.packages = with unstable; [
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
    jdk17
    php
    luajit
  ];

  programs.neovim = {
    package = unstable.neovim-unwrapped;
    enable = true;
    vimAlias = true;
    extraLuaPackages = ps: [
      ps.jsregexp
      ps.tiktoken_core
      ps.luasql-sqlite3
    ];
  };

  home.file = {
    "./.config/nvim/" = {
      source = repo;
      recursive = true;
    };
  };
}
