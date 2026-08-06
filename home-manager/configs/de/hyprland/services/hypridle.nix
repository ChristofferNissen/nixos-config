{ inputs, pkgs, ... }: {
  services.hypridle.enable = true;
  # services.hypridle.package = inputs.hypridle.packages.${pkgs.stdenv.hostPlatform.system}.default;
  services.hypridle.settings = {
    general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
    };
    listener = [
        {
            timeout = 150;
            on-timeout = "brightnessctl -s set 10";
            on-resume = "brightnessctl -r";
        }
        {
            timeout = 300;
            on-timeout = "loginctl lock-session";
        }
        {
            timeout = 330;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on && brightnessctl -r";
        }
        {
            timeout = 1800;
            on-timeout = "systemctl suspend";
        }
    ];
  };
}
