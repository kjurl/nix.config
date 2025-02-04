{ lib, self, inputs, config, username, hostname, ... }:
let
  inherit (lib.utils) findKys setOptions getConfig;
  kys = findKys ./. ++ [ "homeManager" ];
in {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    (lib.mkAliasOptionModule [ "hm" ] [ "home-manager" "users" username ])
  ];
  options = setOptions kys { enable = lib.mkEnableOption "home-manager"; };
  config = let
    cfg = getConfig config kys;
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
        backupFileExtension = "bak";
        users.${username} = usr;
        sharedModules = [ ../../home-manager ];
        extraSpecialArgs = { inherit self inputs username hostname; };
      };
    })

  ];
}
