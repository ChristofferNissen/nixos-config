{
  inputs,
  config,
  pkgs,
  userName,
  stateVersion,
  ...
}:

{ 
  imports = [ inputs.catppuccin.homeManagerModules.catppuccin ];
}
