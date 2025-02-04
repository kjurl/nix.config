{ lib, pkgs, config, inputs, ... }:
let inherit (lib) mkEnableOption;
in {
  # imports = with inputs.haumea.lib;
  #   lib.attrsets.collect builtins.isPath (load {
  #     src = ./.;
  #     loader = loaders.path;
  #     transformer = [
  #       # (transformers.hoistAttrs "options" "options")
  #       # transformers.liftDefault
  #     ];
  #   });
  imports = lib.utils.scanPaths ./. ++ [ ];

  options.modules.programs = {
    media = { enable = mkEnableOption "media tools"; };
  };

  config = let cfg = config.modules.programs;
  in lib.mkMerge [
    {
      home.packages = with pkgs; [
        bitwarden-desktop
        obsidian
        gparted
        clapper
        showtime
        # zapzap
        # inputs.hyprland-qtutils.packages.${pkgs.system}.hyprland-qtutils
      ];
      xdg.desktopEntries."org.gnome.Settings" = {
        name = "Settings";
        comment = "Gnome Control Center";
        icon = "org.gnome.Settings";
        exec =
          "env XDG_CURRENT_DESKTOP=gnome ${pkgs.gnome-control-center}/bin/gnome-control-center";
        categories = [ "X-Preferences" ];
        terminal = false;
      };

      programs = {
        nix-index.enable = true;
        nix-index.enableBashIntegration = true;
        pandoc.enable = false;
      };

    }

    (lib.mkIf cfg.media.enable {
      home.packages = with pkgs; [ playerctl ];
      programs = {
        imv.enable = true;
        mpv = {
          enable = true;
          # defaultprofiles = [ "gpu-hq" ];
          # scripts = [ pkgs.mpvscripts.mpris ];
        };
      };
      # xdg.mimeapps.defaultapplications = {
      #   "audio/*" = "mpv.desktop";
      #   "image/*" = "imv.desktop";
      #   "video/*" = "mpv.desktop";
      # };
    })
  ];
}
