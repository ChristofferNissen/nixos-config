{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./git.nix
    ./neovim.nix
    ./nixpkgs.nix
    ./zsh.nix
  ];
}
