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
    ./term/tmux.nix
    ./term/zsh.nix
    ./term/k9s.nix
  ];
}
