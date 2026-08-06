{ unstable, ... }:
{
  home.packages = [
    (
      with unstable.dotnetCorePackages;
      combinePackages [
        sdk_8_0
        sdk_9_0
        sdk_10_0
      ]
    )
    unstable.dotnet-ef
    unstable.dotnetPackages.Nuget
    # csharp-ls
  ];
}
