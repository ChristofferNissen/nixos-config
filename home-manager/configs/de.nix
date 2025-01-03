{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./hyprland.nix
    ./i3.nix
    ./polybar.nix
    ./rofi.nix
    ./swaylock.nix
  ];
}
