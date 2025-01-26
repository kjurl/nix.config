{ lib, pkgs, ... }: {
  imports = lib.utils.scanPaths ./.;
  home.packages = with pkgs.gnomeExtensions; [
    app-menu-is-back
    arcmenu
    blur-my-shell
    clipboard-indicator
    color-picker
    compact-top-bar
    dash-to-dock
    forge
    fuzzy-app-search
    just-perfection
    logo-menu
    logo-widget
    space-bar
    tweaks-in-system-menu
    vitals
  ];
}
