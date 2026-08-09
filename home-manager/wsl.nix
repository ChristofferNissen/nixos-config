{ userName }:
{
  programs.git.settings.user.email = "@.com";

  home.sessionVariables = {
    NVIM_APPNAME = "local";
  };

  home.homeDirectory = "/home/${userName}";

  imports = [
    ./common.nix
  ];
}
