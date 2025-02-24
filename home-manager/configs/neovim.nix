{ pkgs, ... }:

let
  treesitterWithGrammars = (
    pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [
      p.bash
      p.comment
      p.css
      p.dockerfile
      p.fish
      p.gitattributes
      p.gitignore
      p.go
      p.gomod
      p.gowork
      p.hcl
      p.javascript
      p.jq
      p.json5
      p.json
      p.lua
      p.make
      p.markdown
      p.nix
      p.python
      p.rust
      p.ron
      p.toml
      p.typescript
      p.vue
      p.yaml
      p.gleam
    ])
  );

  treesitter-parsers = pkgs.symlinkJoin {
    name = "treesitter-parsers";
    paths = treesitterWithGrammars.dependencies;
  };
in
{
  home.packages = with pkgs; [
    ripgrep
    fd
    lua-language-server
    #rust-analyzer-unwrapped
    black
    nodejs_22
    gh
    # lynx
    # tiktoken_core
    wget
    luarocks
    biome
    shfmt
  ];

  programs.neovim = {
    enable = true;
    vimAlias = true;
    coc.enable = false;
    withNodeJs = true;

    plugins = [
      treesitterWithGrammars
    ];
  };

  home.file."./.config/nvim/" = {
    source = builtins.fetchGit {
      url = "https://github.com/christoffernissen/lazyvim-config";
      rev = "86929fdec04e2da91992649fb8a579527e639db2";
    };
    recursive = true;
  };

  home.file."./.config/nvim/lua/ChristofferNissen/init.lua".text = ''
    require("ChristofferNissen.set")
    require("ChristofferNissen.remap")
    require("ChristofferNissen.options")
    vim.opt.runtimepath:append("${treesitter-parsers}")
  '';

  # Treesitter is configured as a locally developed module in lazy.nvim
  # we hardcode a symlink here so that we can refer to it in our lazy config
  home.file."./.local/share/nvim/nix/nvim-treesitter/" = {
    recursive = true;
    source = treesitterWithGrammars;
  };

}
