{ userName, ... }:
{
  home.sessionVariables = {
    ATUIN_SYNC_ADDRESS = "https://atuin.houseofsnit.casa";
  };

  home.homeDirectory = "/home/${userName}";

  imports = [
    ./common.nix
    ./configs/de
  ];
}
