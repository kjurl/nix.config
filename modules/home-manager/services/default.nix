{ lib, ... }:
let inherit (lib) mkEnableOption;
in {
  imports = lib.utils.scanPaths ./.;

  options.modules.services = {
    hypridle.enable = mkEnableOption "hypridle daemon";
    hyprpaper.enable = mkEnableOption "hyprpaper daemon";
    swaync.enable = mkEnableOption "swaync notification daemon";
  };

  config = {
    services = {
      cliphist.enable = true;
      kdeconnect = {
        enable = true;
        indicator = true;
      };
    };
    home.sessionVariables.QT_XCB_GL_INTEGRATION = "none";
  };
}
