# All files in this folder are generated
{ lib, pkgs, ... }: {
  imports = lib.utils.scanPaths ./.;
  home.packages = with pkgs.gnomeExtensions; [
    pkgs.dconf-editor
    pkgs.gnome-tweaks

    gsconnect
    just-perfection

    forge

    alphabetical-app-grid
    clipboard-indicator
    color-picker
    dash-to-dock
  ];
}
