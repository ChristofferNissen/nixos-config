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

  patchFile = pkgs.writeText "add-treesitter-parsers.patch" ''
    --- a/init.lua
    +++ b/init.lua
    @@ -3,0 +4 @@ require("ChristofferNissen.options")
    +vim.opt.runtimepath:append("${treesitter-parsers}")
  '';

  repo = builtins.fetchGit {
    url = "https://github.com/ChristofferNissen/lazyvim-config";
    ref = "main";
    rev = "a22bc7be6e0b7e7cf21453c7532e6a9dd2ecc881";
  };

  patchedRepo = pkgs.runCommand "patched-repo" { buildInputs = [ pkgs.patch ]; } ''
    temp_dir=$(mktemp -d)
    cp -r ${repo} $temp_dir/
    ls -lah $temp_dir
    chmod -R +w $temp_dir/*/lua/ChristofferNissen/
    cat $temp_dir/*/lua/ChristofferNissen/init.lua
    patch $temp_dir/*/lua/ChristofferNissen/init.lua < ${patchFile}
    cp -r $temp_dir/* $out
  '';
in
{
  home.packages = with pkgs; [
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
    packer
    tectonic
    texliveSmall
    vimPlugins.luasnip
    mermaid-cli
    ghostscript
  ];

  programs.neovim = {
    enable = true;
    vimAlias = true;
    coc.enable = false;
    withNodeJs = true;

    plugins = [
        treesitterWithGrammars

        ## neotest and dependencies
        pkgs.vimPlugins.neotest
        pkgs.vimPlugins.nvim-nio
        pkgs.vimPlugins.plenary-nvim
        pkgs.vimPlugins.FixCursorHold-nvim
        pkgs.vimPlugins.nvim-treesitter
        (pkgs.vimPlugins.nvim-treesitter.withPlugins (plugins: [plugins.go]))
        pkgs.vimPlugins.neotest-golang

        ## debugging
        pkgs.vimPlugins.nvim-dap
        pkgs.vimPlugins.nvim-dap-ui
        pkgs.vimPlugins.nvim-nio
        pkgs.vimPlugins.nvim-dap-virtual-text
        pkgs.vimPlugins.nvim-dap-go
    ];
  };

  home.file = {
    "./.config/nvim/" = {
      source = patchedRepo;
      recursive = true;
    };

    # Treesitter is configured as a locally developed module in lazy.nvim
    # we hardcode a symlink here so that we can refer to it in our lazy config
    "./.local/share/nvim/nix/nvim-treesitter/" = {
      recursive = true;
      source = treesitterWithGrammars;
    };
  };
}
