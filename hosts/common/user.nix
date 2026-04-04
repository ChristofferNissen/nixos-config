{ userName, description, ... }: {
  users.users.${userName} = {
    isNormalUser = true;
    description = description;
    extraGroups = [ "networkmanager" "wheel" "docker" "input" ];
    home = "/home/${userName}";
  };
}
