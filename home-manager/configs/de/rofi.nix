{ pkgs, ... }:

{
  programs.rofi = {
    enable = true;
  };
    
  home.file."./.config/rofi" = {
    source = ./rofi/.config/rofi;
    recursive = true;
  };

  home.file.".local/share/rofi/themes" = {
    source = ./rofi/.local/share/rofi/themes;
    recursive = true;
  };
}
