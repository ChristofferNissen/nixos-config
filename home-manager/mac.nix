{ ... }:

{
  programs.git.userEmail = "christoffer.nissen@gmail.com";

  home.username = "cn";
  home.homeDirectory = "/Users/cn";

  imports = [ ./common.nix ./packages/main.nix ./configs/main.nix ];
}
