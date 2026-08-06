{ userName, ... }:
{
  home.homeDirectory = "/Users/${userName}";

  imports = [
    ./common.nix
  ];
}
