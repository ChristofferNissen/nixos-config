{ userName, ... }:

{
  programs.git.userEmail = "christoffer.nissen@gmail.com";

  home.username = "${userName}";
  home.homeDirectory = "/home/${userName}";

  home.sessionVariables = { NIXOS_OZONE_WAYLAND = "1"; };

  imports = [
    ./common.nix
    ./packages/main.nix
    ./packages/extra.nix
    ./configs/main.nix
    ./configs/desktopenvironment.nix
  ];
}
