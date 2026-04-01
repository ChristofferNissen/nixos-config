{ userName, ... }:

{
  programs.git.settings.user.email = "@.com";

  home.username = "${userName}";
  home.homeDirectory = "/home/${userName}";

  home.sessionVariables = { NVIM_APPNAME = "local"; };

  imports = [
    ./common.nix
    ./packages/main.nix
    ./packages/sqlite.nix
    ./packages/azure-wsl.nix
    ./configs/main.nix
  ];
}
