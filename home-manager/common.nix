{ inputs, pkgs, userName, stateVersion, ... }:

{
  home.stateVersion = stateVersion;

  imports = [ inputs.catppuccin.homeModules.catppuccin ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.sessionVariables = {
    NIXOS_OZONE_WAYLAND = "1";
    SHELL = "${pkgs.zsh}/bin/zsh";
    KUBE_EDITOR = "vim";
    DOTNET_ROOT = "${pkgs.dotnetCorePackages.sdk_9_0}/share/dotnet";
    DOTNET_SYSTEM_GLOBALIZATION_INVARIANT = 1;
  };

  programs.git = {
    enable = true;
    userName = "Christoffer Nissen";
    extraConfig = {
      init = { defaultBranch = "main"; };
      push = { autoSetupRemote = true; };
      core = { editor = "nvim"; };
    };
  };
}
