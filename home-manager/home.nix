{
  config,
  pkgs,
  ...
}:

{
  programs.git.userEmail = "christoffer.nissen" + "@" + "gmail.com";

  imports = [
    ./common.nix
    ./packages/main.nix
    ./packages/extra.nix
    ./configs/main.nix
    ./configs/desktopenvironment.nix
  ];
}
