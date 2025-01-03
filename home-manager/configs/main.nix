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
    ./kitty.nix
    ./neovim.nix
    ./nixpkgs.nix
    ./vscode.nix
    ./zsh.nix
  ];
}
