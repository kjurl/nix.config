{ lib, pkgs, config, osConfig, ... }:
lib.mkIf osConfig.modules.system.desktop.enable {
  home.packages = [ pkgs.xdg-utils ];

  xdg = {
    portal = {
      enable = true;

      config = {

        common = { default = [ "gtk" ]; };
        pantheon = {
          default = [ "pantheon" "gtk" ];
          "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
        };
        x-cinnamon = { default = [ "xapp" "gtk" ]; };

      };

    };

    userDirs = let home = config.home.homeDirectory;
    in {
      enable = true;
      createDirectories = true;

      extraConfig = { XDG_SCREENSHOTS_DIR = "${home}/Pictures/Screenshots"; };
    };

    mime.enable = true;

    mimeApps = { enable = true; };
  };
}
