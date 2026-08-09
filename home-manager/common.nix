{ stateVersion, userName, ... }:
{
  home.stateVersion = stateVersion;
  home.username = "${userName}";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [
    ./configs
    ./packages
  ];
}
