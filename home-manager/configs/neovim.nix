{ unstable, ... }:

let
  repo = builtins.fetchGit {
    url = "https://github.com/ChristofferNissen/nvim-config";
    ref = "main";
    rev = "901769af3f74aaaa8a0dfb3ecdd1c9619ba7f51d";
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
    vimPlugins.luasnip
    mermaid-cli
    ghostscript
    python312Packages.pylatexenc
    nixd
    nodejs_22
    omnisharp-roslyn
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
