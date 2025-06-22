{ pkgs, ... }:

{
  # Enable Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.systemPackages = with pkgs; [ git vim ];

  programs.zsh.enable = true;
  # Add more darwin-specific settings or packages here

  nix.gc = {
    automatic = true;
    interval = { Weekday = 0; Hour = 0; Minute = 0; };
    options = "--delete-older-than 30d";
  };

  system.stateVersion = 6;
}
