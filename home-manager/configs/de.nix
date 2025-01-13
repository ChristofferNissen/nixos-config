{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./alacritty.nix
    ./ghostty.nix
    ./hyprland.nix
    ./i3.nix
    ./kitty.nix
    ./polybar.nix
    ./rofi.nix
    ./vscode.nix
    ./zen-browser.nix
  ];
}
