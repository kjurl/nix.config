{ lib, pkgs, config, inputs, ... }:
let kys = lib.utils.findKys ./. ++ [ "spotify" ];
in {
  imports = [ inputs.spicetify-nix.homeManagerModules.default ];
  options = lib.utils.setOptions kys { enable = lib.mkEnableOption "spotify"; };
  config = let cfg = lib.utils.getConfig config kys;
  in lib.mkIf cfg.enable {
    programs.spicetify =
      let spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
      in {
        enable = true;
        enabledExtensions = with spicePkgs.extensions; [
          autoSkipVideo
          fullAppDisplay
          adblock
          hidePodcasts
          shuffle # shuffle+
        ];
        enabledCustomApps = with spicePkgs.apps; [ reddit ];
      };
  };
}
