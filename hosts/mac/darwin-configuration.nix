{ pkgs, ... }:

{
  # Enable Flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  environment.systemPackages = with pkgs; [
    git
    vim
  ];

  programs.zsh.enable = true;
  # Add more darwin-specific settings or packages here

  system.stateVersion = 6;
}
