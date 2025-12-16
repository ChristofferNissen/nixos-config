{ userName, ... }:

{
  programs.git.settings.user.email = "christoffer.nissen@gmail.com";

  home.username = "${userName}";
  home.homeDirectory = "/home/${userName}";

  imports = [
    ./common.nix
    ./packages/main.nix
    ./packages/extra.nix
    ./packages/sqlite.nix
    ./packages/azure.nix
    ./configs/main.nix
    ./configs/desktopenvironment.nix
  ];
}
