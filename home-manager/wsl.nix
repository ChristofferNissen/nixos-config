{
  config,
  pkgs,
  ...
}:

{
  programs.git.userEmail = "cnis" + "@" + "bankingcircle.com";

  imports = [
    ./common.nix
    ./packages/main.nix
    ./configs/main.nix
  ];
}
