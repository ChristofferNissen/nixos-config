{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./alacritty.nix
    ./i3.nix
    ./polybar.nix
    ./rofi.nix
    ./vscode.nix
    ./zsh.nix
    ./git.nix
  ];
}
