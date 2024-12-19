{ lib, pkgs, config, osConfig, ... }:
lib.mkIf osConfig.modules.system.desktop.enable {
  home.packages = [ pkgs.xdg-utils ];

  xdg = {
    portal = { enable = true; };

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
