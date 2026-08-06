{ inputs, pkgs, ... }: {
  services.hyprpaper.enable = true;
  # services.hyprpaper.package = inputs.hyprpaper.packages.${pkgs.stdenv.hostPlatform.system}.default;
  services.hyprpaper.settings = {
    splash = false;
    wallpaper = [
      {
        monitor = "";
        path = "/home/cn/Downloads/paper.jxl";
      }
    ];
  };
}
