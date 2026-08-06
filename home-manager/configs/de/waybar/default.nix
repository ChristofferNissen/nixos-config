{ ... }: {
  home.file."./.config/waybar" = {
    source = ./files;
    recursive = true;
  };
}
