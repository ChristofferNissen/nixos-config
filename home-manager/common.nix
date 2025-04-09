{
  inputs,
  pkgs,
  userName,
  stateVersion,
  ...
}:

{
  home.stateVersion = stateVersion;

  imports = [
    inputs.catppuccin.homeModules.catppuccin
  ];

  home.username = "${userName}";
  home.homeDirectory = "/home/${userName}";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.sessionVariables = {
    NIXOS_OZONE_WAYLAND = "1";
    SHELL = "${pkgs.zsh}/bin/zsh";
    KUBE_EDITOR = "vim";
  };

  programs.git = {
    enable = true;
    userName = "Christoffer Nissen";
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
      push = {
        autoSetupRemote = true;
      };
    };
  };
}
