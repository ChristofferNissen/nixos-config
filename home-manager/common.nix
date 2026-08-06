{ inputs, pkgs, unstable, stateVersion, userName, ... }:
{
  home.stateVersion = stateVersion;
  home.username = "${userName}";
  home.homeDirectory = "/home/${userName}";

  imports = [
    inputs.catppuccin.homeModules.catppuccin 

    ./configs
    ./packages
  ];

  catppuccin = {
    autoEnable = false;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.sessionVariables = {
    SHELL = "${pkgs.zsh}/bin/zsh";
    KUBE_EDITOR = "vim";
    # DOTNET_ROOT = "${(with unstable.dotnetCorePackages; combinePackages [ sdk_8_0 sdk_9_0 sdk_10_0 ])}/share/dotnet";
    # DOTNET_SYSTEM_GLOBALIZATION_INVARIANT = 0;
    # LD_LIBRARY_PATH = "${pkgs.icu}/lib\${LD_LIBRARY_PATH:+:\$LD_LIBRARY_PATH}";
  };

  programs.git = {
    enable = true;
    signing = {
        format = null;
    };
    settings = {
      user =
        {
          name = "Christoffer Nissen";
          email = "christoffer.nissen@gmail.com";
        };
      init = {
        defaultBranch = "main";
      };
      push = { autoSetupRemote = true; };
      core = { editor = "nvim"; };
    };
  };
}
