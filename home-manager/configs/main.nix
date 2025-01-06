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
    ./zsh.nix
  ];
}
