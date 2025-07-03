{ unstable, ... }:

let
  repo = builtins.fetchGit {
    url = "https://github.com/ChristofferNissen/nvim-config";
    ref = "main";
    rev = "c51cb255afd27ee6e17335f76f0edda29cd3e339";
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
    sqlite
    julia-bin
    mercurial
  ];

  programs.neovim = {
    package = unstable.neovim-unwrapped;
    enable = true;
    vimAlias = true;
    extraLuaPackages = ps: [ ps.jsregexp ps.tiktoken_core ps.luasql-sqlite3 ];
  };

  home.sessionVariables = {
    LIBSQLITE = "${unstable.sqlite.out}/lib/libsqlite3.so";
  };

  home.file = {
    "./.config/nvim/" = {
      source = repo;
      recursive = true;
    };
  };
}
