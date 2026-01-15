{ userName, description, ... }: {
  users.users.${userName} = {
    isNormalUser = true;
    description = description;
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    home = "/home/${userName}";
  };
}
