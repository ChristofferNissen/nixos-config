{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    extraConfig = ''
      shell zsh
    '';
  };


}
