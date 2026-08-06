{ inputs, pkgs, ... }: {
  services.hyprsunset.enable = true;
  # services.hyprsunset.package = inputs.hyprsunset.packages.${pkgs.stdenv.hostPlatform.system}.default;
  services.hyprsunset.settings = {
    max-gamma = 150;
    profile = [
      {
        time = "7:30";
        identity = true;
      }
      {
        time = "21:00";
        temperature = 5000;
        gamma = 0.8;
      }
    ];
  };
}
