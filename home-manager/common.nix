{
  inputs,
  config,
  pkgs,
  userName,
  stateVersion,
  ...
}:

{
  imports = [ 
    inputs.catppuccin.homeModules.catppuccin
    ./packages/helm.nix
  ];

  home.username = "${userName}";
  home.homeDirectory = "/home/${userName}";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.stateVersion = stateVersion;

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
