{ inputs, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    extraConfig = ''
      shell zsh
    '';
  };

  catppuccin.kitty = {
    enable = true;
  };
}
