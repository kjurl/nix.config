{ lib, self, inputs, config, username, hostname, ... }:
lib.x.options.auto ./. config [ "homeManager" ] (cfg: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    # (lib.mkAliasOptionModule [ "hm" ] [ "home-manager" "users" username ])
  ];
  options.enable = lib.mkEnableOption "home-manager";
  config = let
    userPath = lib.pipe "@" [
      (x: "${username}${x}${hostname}.nix")
      (x: lib.path.append ../../../systems x)
    ];
    usr = import userPath;
  in lib.mkMerge [

    {
      users = {
        mutableUsers = false;
        users.${username} = {
          isNormalUser = true;
          initialPassword = usr.main.password;
          extraGroups = usr.main.groups;
        };
      };
    }

    (lib.mkIf cfg.enable {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = "hmbak";
        users.${username} = usr;
        sharedModules = [ ../../home-manager ];
        extraSpecialArgs = { inherit self inputs username hostname; };
      };
    })

  ];

})
