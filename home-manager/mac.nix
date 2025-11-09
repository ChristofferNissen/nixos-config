{ userName, ... }:

{
  programs.git.settings.user.email = "christoffer.nissen@gmail.com";

  home.username = "${userName}";
  home.homeDirectory = "/Users/${userName}";

  imports = [ ./common.nix ./packages/main.nix ./configs/main.nix ];
}
