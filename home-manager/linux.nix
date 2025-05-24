{
  userName,
  ...
}:

{
  programs.git.userEmail = "christoffer.nissen@gmail.com";

  home.username = "${userName}";
  home.homeDirectory = "/home/${userName}";

  imports = [
    ./common.nix
    ./packages/main.nix
    ./packages/extra.nix
    ./configs/main.nix
    ./configs/desktopenvironment.nix
  ];
}
