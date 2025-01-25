{ lib, pkgs, config, ... }:
let kys = lib.utils.findKys ./. ++ [ "bottles" ];
in {
  options = lib.utils.setOptions kys { enable = lib.mkEnableOption "bottles"; };
  config = let cfg = lib.utils.getConfig config kys;
  in lib.mkIf cfg.enable { home.packages = [ pkgs.bottles ]; };
}
