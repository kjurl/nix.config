{ lib, pkgs, config, osConfig, ... }:
lib.mkIf osConfig.modules.system.desktop.enable {
  gtk = {
    enable = true;
    theme = {
      name = "adw-gtk3";
      package = lib.mkDefault pkgs.adw-gtk3;
    };

    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
      # package = pkgs.papirus-icon-theme;
    };

    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
    gtk3.bookmarks = [
      "file://${config.home.homeDirectory}/Documents"
      "file://${config.home.homeDirectory}/Downloads"
      "file://${config.home.homeDirectory}/Music"
      "file://${config.home.homeDirectory}/Pictures"
      "file://${config.home.homeDirectory}/Videos"
    ];
  };

  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  qt = {
    enable = true;
    platformTheme.name = "gtk";
  };
}
