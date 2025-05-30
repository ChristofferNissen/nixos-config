{ config, pkgs, ... }: {
  home.file."./.config/k9s" = {
    source = ./k9s;
    recursive = true;
  };
}
