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
    rev = "65264e8050ccc2ea0fac5d58c22c08a51dec9b3d";
  };

  # cleanedRepo = pkgs.runCommand "cleaned-repo" {} ''
  #   cp -r ${repo} $out
  #   rm -f $out/.config/nvim/lua/ChristofferNissen/init.lua
  # '';
  patchedRepo = pkgs.runCommand "patched-repo" { buildInputs = [ pkgs.patch ]; } ''
    # cp -r ${repo} $out
    # patch $out/lua/ChristofferNissen/init.lua < ${patchFile}

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

  # home.file."./.config/nvim/" = {
  #   source = builtins.fetchGit {
  #     url = "https://github.com/christoffernissen/lazyvim-config";
  #     rev = "65264e8050ccc2ea0fac5d58c22c08a51dec9b3d";
  #   };
  #   recursive = true;
  # };
  #
  # home.file."./.config/nvim/lua/ChristofferNissen/init.lua".text = ''
  #   require("ChristofferNissen.set")
  #   require("ChristofferNissen.remap")
  #   require("ChristofferNissen.options")
  #   vim.opt.runtimepath:append("${treesitter-parsers}")
  # '';

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

  # home.file = {
  #   "./.config/nvim/" = {
  #     source = cleanedRepo;
  #     recursive = true;
  #   };
  #
  #   "./.config/nvim/lua/ChristofferNissen/init.lua" = {
  #     source = cleanedRepo + "/.config/nvim/lua/ChristofferNissen/init.lua";
  #     force = true; # Ensure the file is overwritten
  #     onChange = ''
  #       # cp ./.config/nvim/lua/ChristofferNissen/init.lua init.lua
  #       chmod +w ./.config/nvim/lua/ChristofferNissen/init.lua
  #       # chmod +w init.lua
  #       ${pkgs.patch}/bin/patch init.lua < ${patchFile}
  #       # mv init.lua $out
  #
  #       # temp_file=$(mktemp)
  #       # cp ./.config/nvim/lua/ChristofferNissen/init.lua $temp_file
  #       # chmod +w $temp_file
  #       # ${pkgs.patch}/bin/patch $temp_file < ${patchFile}
  #       # mv $temp_file ./.config/nvim/lua/ChristofferNissen/init.lua
  #     '';
  #   };
  # };

  # home.file = {
  #   "./.config/nvim/" = {
  #     source = builtins.fetchGit {
  #       url = "https://github.com/christoffernissen/lazyvim-config";
  #       rev = "65264e8050ccc2ea0fac5d58c22c08a51dec9b3d";
  #     };
  #     recursive = true;
  #   };
  #
  #   # Apply the patch to the init.lua file
  #   "./.config/nvim/lua/ChristofferNissen/init.lua" = {
  #     source = ./init.lua;
  #     force = true; # Ensure the file is overwritten
  #     onChange = ''
  #       patch /home/cn/.config/nvim/lua/ChristofferNissen/init.lua < ${patchFile}
  #     '';
  #   };

    # # Apply the patch to the init.lua file
    # "./.config/nvim/lua/ChristofferNissen/init.lua" = {
    #   source = pkgs.runCommand "patched-init.lua" { buildInputs = [ pkgs.patch ]; } ''
    #     cp ${/home/cn/.config/nvim/lua/ChristofferNissen/init.lua} init.lua
    #     chmod +w init.lua
    #     patch init.lua ${patchFile}
    #     cat init.lua
    #     mv init.lua $out
    #   '';
    #   # force = true; # Ensure the file is overwritten
    # }; 

    # # Explicitly overwrite the init.lua file
    # "./.config/nvim/lua/ChristofferNissen/init.lua" = {
    #   text = ''
    #     require("ChristofferNissen.set")
    #     require("ChristofferNissen.remap")
    #     require("ChristofferNissen.options")
    #     vim.opt.runtimepath:append("${treesitter-parsers}")
    #   '';
    #   force = true; # Ensure the file is overwritten
    # }; 

  # };

  # Treesitter is configured as a locally developed module in lazy.nvim
  # we hardcode a symlink here so that we can refer to it in our lazy config
  # home.file."./.local/share/nvim/nix/nvim-treesitter/" = {
  #   recursive = true;
  #   source = treesitterWithGrammars;
  # };

}
