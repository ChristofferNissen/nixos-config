{ unstable, ... }:

let
  repo = builtins.fetchGit {
    url = "https://github.com/ChristofferNissen/nvim-config";
    ref = "main";
    rev = "5cb965cc9c046d3754ea314c6eee59b021d117c6";
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
