{
  config,
  pkgs,
  userName,
  stateVersion,
  ...
}:

{
  home.username = "${userName}";
  home.homeDirectory = "/home/${userName}";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.stateVersion = stateVersion;

  home.sessionVariables = {
    SHELL = "${pkgs.zsh}/bin/zsh";
  };

  programs.git = {
    enable = true;
    userName = "Christoffer Nissen";
    userEmail = "cnis" + "@" + "bankingcircle.com";
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
      push = {
        autoSetupRemote = true;
      };
    };
  };

  imports = [
    ./common.nix
    ./packages/main.nix
    ./configs/main.nix
  ];
}
