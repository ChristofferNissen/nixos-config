{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./alacritty.nix
    ./hyprland.nix
    ./i3.nix
    ./kitty.nix
    ./polybar.nix
    ./rofi.nix
    ./swaylock.nix
    ./vscode.nix
  ];
}
