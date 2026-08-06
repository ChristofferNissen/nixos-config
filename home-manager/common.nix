{ stateVersion, userName, ... }:
{
  home.stateVersion = stateVersion;
  home.username = "${userName}";
  home.homeDirectory = "/home/${userName}";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [
    ./configs
    ./packages
  ];
}
