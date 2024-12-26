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
    ./neovim.nix
    ./nixpkgs.nix
    ./polybar.nix
    ./rofi.nix
    ./vscode.nix
    ./zsh.nix
  ];
}
