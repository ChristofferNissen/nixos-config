{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./nixpkgs.nix
    ./neovim.nix
    ./term/tmux.nix
    ./term/zsh.nix
    ./term/k9s.nix
  ];
}
