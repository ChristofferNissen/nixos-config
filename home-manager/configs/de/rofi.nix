{ ... }: {
  programs.rofi = { enable = true; };

  home.file."./.config/rofi/config.rasi" = {
    source = ./rofi/config.rasi;
    recursive = true;
  };

  home.file.".local/share/rofi/themes" = {
    source = ./rofi/themes;
    recursive = true;
  };
}
