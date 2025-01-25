{ config, pkgs, ... }:
{
  # catppuccin.k9s.enable = true;
  # catppuccin.k9s.flavor = "mocha";
  home.file."./.config/k9s" = {
    source = ./k9s;
    recursive = true;
  };
}
