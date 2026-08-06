{ userName, description, ... }: {
  users.users.${userName} = {
    isNormalUser = true;
    description = description;
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "input"
      "audio"
    ];
    home = "/home/${userName}";
  };
}
