{ stateVersion, userName, lib, ... }:
{
  home.stateVersion = stateVersion;
  home.username = "${userName}";
  home.homeDirectory = lib.mkDefault "/home/${userName}";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [
    ./configs
    ./packages
  ];
}
