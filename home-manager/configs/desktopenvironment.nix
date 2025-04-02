{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./de/hyprland/hyprland.nix
    ./de/hyprland/polybar.nix
    ./de/i3/i3.nix
    ./term/ghostty.nix
    ./term/kitty.nix
    ./de/rofi.nix
    ./de/vscode.nix
    ./de/zen-browser.nix
  ];
}
