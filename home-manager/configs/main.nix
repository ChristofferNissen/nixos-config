{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./alacritty.nix
    ./direnv.nix
    ./git.nix
    ./hyprland.nix
    ./i3.nix
    ./kitty.nix
    ./neovim.nix
    ./nixpkgs.nix
    ./polybar.nix
    ./rofi.nix
    ./swaylock.nix
    ./vscode.nix
    ./zsh.nix
  ];
}
