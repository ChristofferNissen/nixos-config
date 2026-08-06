{ ... }: {
  home.file."./.config/k9s" = {
    source = ./dotfiles;
    recursive = true;
  };
}
