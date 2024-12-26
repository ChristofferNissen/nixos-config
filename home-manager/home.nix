{ config, pkgs, userName, ... }:

{
  
  home.username = "${userName}";
  home.homeDirectory = "/home/${userName}";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Enable programs
  programs = {
    command-not-found.enable = true;
    zsh.enable = true;
    zsh.enableCompletion = true;
  };

  home.stateVersion = "24.11";

  imports = [ ./packages/main.nix ./configs/main.nix ];
  
}
