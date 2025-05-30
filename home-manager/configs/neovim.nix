{ unstable, ... }:

let
  repo = builtins.fetchGit {
    url = "https://github.com/ChristofferNissen/nvim-config";
    ref = "main";
    rev = "a83cc52a3f9577d6407564d59e86feee16283417";
  };
in {
  home.packages = with unstable; [
    tree-sitter
    ripgrep
    fd
    wget
    luarocks
    biome
    tectonic
    texliveSmall
    vimPlugins.luasnip
    mermaid-cli
    ghostscript
    python312Packages.pylatexenc
    nixd
    nodejs_22
    omnisharp-roslyn
    inotify-tools
    php84Packages.composer
    jdk17
    julia
    php
    luajit
    lua51Packages.tiktoken_core
    lua51Packages.luasql-sqlite3
    sqlite
  ];

  programs.neovim = {
    package = unstable.neovim-unwrapped;
    enable = true;
    vimAlias = true;
  };

  home.file = {
    "./.config/nvim/" = {
      source = repo;
      recursive = true;
    };
  };
}
