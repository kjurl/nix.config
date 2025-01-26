{ lib, pkgs, ... }: {
  imports = lib.utils.scanPaths ./.;
  home.packages = with pkgs.gnomeExtensions; [
    pkgs.dconf-editor
    pkgs.gnome-tweaks

    arcmenu
    blur-my-shell
    clipboard-indicator
    color-picker
    dash-to-dock
    forge
    fuzzy-app-search
    just-perfection
    logo-menu
    space-bar
    vitals
  ];
}
