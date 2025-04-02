{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./de/hyprland.nix
    ./de/i3.nix
    ./term/ghostty.nix
    ./term/kitty.nix
    ./de/polybar.nix
    ./de/rofi.nix
    ./de/vscode.nix
    ./de/zen-browser.nix
  ];
}
