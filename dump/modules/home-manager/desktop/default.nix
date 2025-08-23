# All files in this folder are generated
{ lib, pkgs, osConfig, ... }: {
  imports = lib.x.imports.scanPaths ./.;
  config = lib.mkIf osConfig.modules.system.desktop.enable {
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

    programs.obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        droidcam-obs
        looking-glass-obs
        obs-backgroundremoval
        obs-move-transition
        obs-multi-rtmp
        obs-pipewire-audio-capture
        wlrobs
      ];
    };
  };
}
