{ username, ... }: {
  users = {
    mutableUsers = false;
    users.${username} = {
      isNormalUser = true;
      initialPassword = "nixos";
      extraGroups = [ "wheel" ];
    };
  };
}
