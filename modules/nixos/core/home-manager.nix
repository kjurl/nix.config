{ lib, self, inputs, config, username, hostname, ... }:
let
  inherit (lib.utils) findKys setOptions getConfig;
  kys = findKys ./. ++ [ "homeManager" ];
  chr = "@";
in {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    (lib.mkAliasOptionModule [ "hm" ] [ "home-manager" "users" username ])
  ];
  options = setOptions kys { enable = lib.mkEnableOption "home-manager"; };
  config = let cfg = getConfig config kys;
  in lib.mkIf cfg.enable {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "backup";
      users.${username} =
        import ../../../systems/${username}${chr}${hostname}.nix;
      sharedModules = [ ../../home-manager ];
      extraSpecialArgs = { inherit self inputs username hostname; };
    };
  };
}
