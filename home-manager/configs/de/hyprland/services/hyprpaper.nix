{ inputs, pkgs, ... }: {
  services.hyprpaper.enable = true;
  # services.hyprpaper.package = inputs.hyprpaper.packages.${pkgs.stdenv.hostPlatform.system}.default;
  services.hyprpaper.settings = {
      preload = "/home/cn/Downloads/paper.jxl";
      wallpaper = "eDP-1,/home/cn/Downloads/paper.jxl";
  };
}
