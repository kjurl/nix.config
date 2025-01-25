{ lib, pkgs, ... }: {
  imports = lib.utils.scanPaths ./.;
  home.packages = with pkgs.gnomeExtensions; [
    app-menu-is-back
    arcmenu
    blur-my-shell
    # caffeine
    clipboard-indicator
    color-picker
    dash-to-dock
    forge
    fuzzy-app-search
    logo-menu
    logo-widget
    # quick-settings-tweaker
    # sound-output-device-chooser
    space-bar
    # tray-icons-reloaded
    tweaks-in-system-menu
    vitals
  ];
}
