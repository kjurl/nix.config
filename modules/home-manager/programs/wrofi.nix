# https://github.com/search?q=rofi+language%3ANIx&type=repositories
# https://github.com/adi1090x/rofi
# https://github.com/Heus-Sueh/rofi-themes
# https://gist.github.com/amanullahmenjli/e2a22e881c823de2b94429a3e714cfc9
{ lib, pkgs, config, ... }:
let kys = lib.utils.findKys ./. ++ [ "rofi" ];
in {
  options = lib.utils.setOptions kys { enable = lib.mkEnableOption "rofi"; };
  config = let cfg = lib.utils.getConfig config kys;
  in lib.mkIf cfg.enable {
    programs.rofi = let
      defaultConfig = {
        # terminal = "${config.modules.desktop.terminal.default}";
        terminal = "kitty";
        disable-history = false;
        show-icons = true;
        sidebar-mode = false;
        sort = true;

        drun-display-format = "{icon} {name}";
        display-drun = "   Run ";
        display-window = " 﩯 Window ";
        display-power-menu = "  Power Menu ";

        modi = lib.strings.concatStringsSep "," [
          "run"
          "drun"
          "filebrowser"
          "power-menu:${lib.getExe pkgs.rofi-power-menu}"
        ];

        xoffset = 0;
        yoffset = 0;
      };
    in {
      enable = true;
      package = pkgs.rofi-wayland;
      plugins = [ pkgs.rofi-power-menu ];
      pass = {
        enable = true;
        package = pkgs.rofi-rbw-wayland;
      };
      extraConfig = let

        window-width = "800px";
        window-height = "550px";
        window-border = "1.75px";
        window-border-color = "#4A4A4C";
        window-border-radius = "12px";
        window-bg-color = "rgba(26, 27, 38, 0.65)";

        bg-col-light = "#1e1e2e";
        selected-col = "#1e1e2e";
        blue = "#89b4fa";
        fg-col = "#cdd6f4";
        fg-col2 = "#f38ba8";
        grey = "#6c7086";
      in { };
    };
  };
}
