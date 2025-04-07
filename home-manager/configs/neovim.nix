{ unstable, ... }:

let
  repo = builtins.fetchGit {
    url = "https://github.com/ChristofferNissen/nvim-config";
    ref = "main";
    rev = "be4839bb5df1cd7049f6dc8e5e970ef168fe9a0b";
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
