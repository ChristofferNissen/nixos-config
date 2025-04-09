{ unstable, ... }:

let
  repo = builtins.fetchGit {
    url = "https://github.com/ChristofferNissen/nvim-config";
    ref = "main";
    rev = "67a629c62a31ccdf20b0558783875f38da4bc140";
  };
in
{
  home.packages = with unstable; [
    tree-sitter
    ripgrep
    fd
    lua-language-server
    yaml-language-server
    docker-compose-language-service
    dockerfile-language-server-nodejs
    black
    gh
    wget
    luarocks
    biome
    shfmt
    # packer
    tectonic
    texliveSmall
    vimPlugins.luasnip
    mermaid-cli
    ghostscript
    marksman
    markdownlint-cli2
    terraform-ls
    gopls
    gosimports
    gofumpt
    gomodifytags
    impl
    delve
    tflint
    python312Packages.pylatexenc
    nixd
    zls
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
      source = repo;
      recursive = true;
    };
  };
}
