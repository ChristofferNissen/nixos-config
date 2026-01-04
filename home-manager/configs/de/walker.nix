{ inputs, ... }: {
  imports = [ inputs.walker.homeManagerModules.default ];
  programs.walker = {
    enable = true;
    runAsService =
      true; # Note: this option isn't supported in the NixOS module only in the home-manager module
    config = {
      providers.prefixes = [
        {
          provider = "websearch";
          prefix = "+";
        }
        {
          provider = "providerlist";
          prefix = "_";
        }
      ];
    };
  };
}
