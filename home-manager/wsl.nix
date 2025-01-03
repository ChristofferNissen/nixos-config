{ config, pkgs, userName, stateVersion, ... }:

{
  home.username = "${userName}";
  home.homeDirectory = "/home/${userName}";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.stateVersion = stateVersion;

  home.sessionVariables = {
    SHELL = "${pkgs.zsh}/bin/zsh";
  };

  imports = [ ./packages/main.nix ./configs/main.nix ];
}
