{ pkgs, unstable, ... }:
let
  # Step out of configs/ and look inside packages/
  myDotnetPkgs = import ../packages/dotnet.nix { inherit unstable; };
in
{
  home.packages = [
    myDotnetPkgs
    unstable.dotnet-ef
    unstable.dotnetPackages.Nuget
    # csharp-ls
  ];

  home.sessionVariables = {
    DOTNET_ROOT = "${myDotnetPkgs}/share/dotnet";
    DOTNET_SYSTEM_GLOBALIZATION_INVARIANT = 0;
    LD_LIBRARY_PATH = "${pkgs.icu}/lib\${LD_LIBRARY_PATH:+:\$LD_LIBRARY_PATH}";
  };

  home.sessionPath = [
    "$HOME/.dotnet/tools"
  ];
}
