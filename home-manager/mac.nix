{ userName, ... }:
{
  home.homeDirectory = "/Users/${userName}";

  home.sessionVariables = {
    ATUIN_SYNC_ADDRESS = "https://atuin.houseofsnit.casa";
    TALOSCONFIG = "/Users/cn/homek8s/talos/talosconfig";
    K9S_CONFIG_DIR = "/Users/cn/.config/k9s";
  };

  imports = [
    ./common.nix
  ];
}
