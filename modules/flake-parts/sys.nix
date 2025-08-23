{ lib, self, inputs, outputs, getSystem, ... }: {
  flake = let
    secrets = builtins.fromJSON (builtins.readFile "${self}/secrets.json");
    mkHost = hostname: username: system: {
      ${hostname} = lib.nixosSystem {
        inherit system;
        specialArgs = { inherit self inputs outputs hostname username lib; };
        modules = if (lib.hasPrefix "installer" hostname) then
          [ ../../systems/installer ]
        else [
          ../../systems/${hostname}
          ../../modules/nixos
        ];
      };
    };
  in {
    nixosConfigurations = lib.mkMerge [
      # (mkHost "di15-7567g" "kanishkc" "x86_64-linux" )
      (mkHost "winnix" "nixos" "x86_64-linux")
    ];
  };
}
