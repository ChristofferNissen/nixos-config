{ config, pkgs, lib, ... }: {
  imports = [ ./neovim.nix ./term/tmux.nix ./term/zsh.nix ./term/k9s.nix ];
}
