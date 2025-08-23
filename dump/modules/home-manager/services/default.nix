{ lib, ... }:
let inherit (lib) mkEnableOption;
in {
  imports = lib.x.imports.scanPaths ./.;

  options.modules.services = {
    flatpak.enable = mkEnableOption "flatpak service";
    hypridle.enable = mkEnableOption "hypridle daemon";
    hyprpaper.enable = mkEnableOption "hyprpaper daemon";
    kdeconnect.enable = mkEnableOption "kdeconnect daemon";
    swaync.enable = mkEnableOption "swaync notification daemon";
  };

  config = {
    services = { cliphist.enable = true; };
    home.sessionVariables.QT_XCB_GL_INTEGRATION = "none";
  };
}
