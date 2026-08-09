{ pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.systemPackages = with pkgs; [ git vim ];

  programs.zsh.enable = true;

  environment.systemPath = [
    "/opt/homebrew/bin"
  ];

  environment.variables = {
    CONFIG = "mac";
  };

  nix.gc = {
    automatic = true;
    interval = {
      Weekday = 0;
      Hour = 0;
      Minute = 0;
    };
    options = " - -delete-older-than 30 d ";
  };

  system.stateVersion = 6;
}

