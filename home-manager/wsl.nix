{
  programs.git.settings.user.email = "@.com";

  home.sessionVariables = {
    NVIM_APPNAME = "local";
  };

  imports = [
    ./common.nix
  ];
}
