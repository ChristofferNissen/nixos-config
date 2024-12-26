{ pkgs, ...}:

{
  programs.neovim = {
    enable = true;
    # extraConfig = ''
    #   set number relativenumber
    # '';
  };
  programs.neovim.plugins = with pkgs.vimPlugins; [
    nvim-treesitter.withAllGrammars
  ];
}
