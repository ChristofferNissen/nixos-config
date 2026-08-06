{pkgs, unstable, ...}:
{
  home.sessionVariables = {
    DOTNET_ROOT = "${(with unstable.dotnetCorePackages; combinePackages [ sdk_8_0 sdk_9_0 sdk_10_0 ])}/share/dotnet";
    DOTNET_SYSTEM_GLOBALIZATION_INVARIANT = 0;
    LD_LIBRARY_PATH = "${pkgs.icu}/lib\${LD_LIBRARY_PATH:+:\$LD_LIBRARY_PATH}";
  };
}
