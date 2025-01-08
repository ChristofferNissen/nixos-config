{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./neovim.nix
    ./nixpkgs.nix
    ./tmux.nix
    ./zsh.nix
  ];
}
