{ lib, pkgs, config, ... }:
let
  kys = lib.utils.findKys ./. ++ [ "wofi" ];
  styles = {
    "0" = {
      url =
        "https://raw.githubusercontent.com/calthejuggler/awesome-wofi/refs/heads/main/themes/raycast/style.css";
      sha256 = "0qna8hm309g81nhyiac4k9vdr7y57pzrwr3bv9y4lwzbcyxn1i0l";
    };
    "1" = {
      url =
        "https://gist.githubusercontent.com/veloii/033300e532c43e3cdbd25a145bae2c66/raw/b4b807a243c975f962975b519467f8388b22c29e/style.css";
      sha256 = "1pyflwmw3mlw9jcrbf0phkfnqyvj069637db1jh0by407cqyq4j0";
    };
  };
in {
  options = lib.utils.setOptions kys {
    enable = lib.mkEnableOption "wofi";
    raycast = lib.mkOption {
      type = lib.types.enum
        (map (x: lib.strings.toIntBase10 x) (lib.attrNames styles));
      default = 0;
    };
  };
  config = let
    inherit (lib) getExe getExe';
    cfg = lib.utils.getConfig config kys;
  in lib.mkIf cfg.enable {
    programs.wofi = {
      enable = true;
      settings = {
        columns = 1;
        height = "55%";
        hide_scroll = true;
        insensitive = true;
        layer = "top";
        location = "center";
        no_actions = true;
        orientation = "vertical";
        prompt = "";
        width = "25%";
      };

      style = let
        style =
          builtins.readFile (builtins.fetchurl styles.${toString cfg.raycast});
      in lib.mkForce style;
    };

    desktop.hyprland.settings = {
      layerrule = [ "blur, wofi # Add blur to wofi" ];
      decoration.blur = {
        enabled = true;
        # size = 20;
        # passes = 3;
      };
    };

    desktop.hyprland.settings.bindr = let
      pkill = getExe' pkgs.procps "pkill";
      wofi = getExe config.programs.wofi.package;
      wofi-emoji = getExe pkgs.wofi-emoji;
      cliphist = getExe pkgs.cliphist;
      wl-copy = getExe' pkgs.wl-clipboard "wl-copy";
    in [
      "SUPER, A, exec, ${pkill} wofi || ${wofi} --show drun"
      "SUPER, E, exec, ${pkill} wofi || ${wofi-emoji}"
      "SUPER, V, exec, ${pkill} wofi || ${cliphist} list | ${wofi} --dmenu | ${cliphist} decode | ${wl-copy}"
      "SUPER, SPACE, exec, ${pkill} wofi || wofi --width=900 --height=500 --gtk-dark -a --allow-images --show drun"
    ];

  };
}
