# https://nixos.wiki/wiki/VSCodium
{ lib, pkgs, config, ... }:
let cfg = config.modules.programs.office;
in {
  options.modules.programs.office.enable =
    lib.mkEnableOption "linux office suite";
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      todoist-electron
      obsidian
      gnome-text-editor
      evince
    ];
  };
}
