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
    DOTNET_ROOT = "${pkgs.dotnetCorePackages.sdk_9_0}/share/dotnet";
    # DOTNET_ROOT = "/etc/profiles/per-user/${userName}/bin/dotnet";
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
