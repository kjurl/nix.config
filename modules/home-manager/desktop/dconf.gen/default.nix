# All files in this folder are generated
{ lib, pkgs, ... }: {
  imports = lib.utils.scanPaths ./.;
  home.packages = with pkgs.gnomeExtensions; [
    pkgs.dconf-editor
    pkgs.gnome-tweaks

    alphabetical-app-grid
    arcmenu
    blur-my-shell
    clipboard-indicator
    color-picker
    dash-to-dock
    forge
    fuzzy-app-search
    gsconnect
    just-perfection
    logo-menu
    space-bar
    vitals
  ];
}
