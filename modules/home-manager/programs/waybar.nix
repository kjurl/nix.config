{ lib, pkgs, config, inputs, ... }:
let kys = lib.utils.findKys ./. ++ [ "waybar" ];
in {
  options = lib.utils.setOptions kys { enable = lib.mkEnableOption "waybar"; };
  config = let cfg = config.modules.programs.waybar;
  in lib.mkIf cfg.enable {
    desktop.hyprland.keybinds = let
      script = pkgs.writeShellScript "reload-waybar.sh" # !/usr/bin/env bash
        ''
          pkill waybar 
          waybar &
        '';
    in [ "SUPER SHIFT, R, exec, ${script}" ];

    desktop.hyprland.settings = {
      layerrule = [
        "blur, waybar # Add blur to waybar"
        "blurpopups, waybar # Blur waybar popups too!"
        "ignorealpha 0.2, waybar # Make it so transparent parts are ignored"
      ];
    };

    home.packages = with pkgs; [ bluez-tools brightnessctl python bluetui ];

    services = {
      blueman-applet.enable = true;
      network-manager-applet.enable = true;
    };

    programs.waybar = {
      enable = true;
      systemd.enable = true;
      package = pkgs.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      });

      # settings = let
      #   fromJSONC = jsonc:
      #     builtins.fromJSON (builtins.readFile (pkgs.runCommand "from-jsonc" {
      #       FILE = pkgs.writeText "file.jsonc" jsonc;
      #       allowSubstitutes = false;
      #       preferLocalBuild = true;
      #     } ''
      #       # it's awkward, but it's works 😏
      #       ${pkgs.gcc}/bin/cpp -P -E "$FILE" > $out
      #       # or clang
      #     ''));
      # in fromJSONC (builtins.readFile ./waybar.settings.jsonc);
      # style = builtins.readFile ./waybar.style.css;

    };
    xdg.configFile."waybar".source = let
      mkMutableSymlink = path:
        config.lib.file.mkOutOfStoreSymlink
        (builtins.readFile inputs.root.outPath
          + lib.strings.removePrefix (toString inputs.self) (toString path));
    in mkMutableSymlink ../../../config/waybar;
    # in config.lib.file.mkOutOfStoreSymlink ok;
  };
}
