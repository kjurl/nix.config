{ lib, pkgs, config, inputs, ... }:
let inherit (lib) mkEnableOption;
in {
  imports = lib.utils.scanPaths ./.;
  options.modules.programs = {
    git = {
      enable = mkEnableOption "git";
      userEmail = lib.mkOption { type = lib.types.str; };
      userName = lib.mkOption { type = lib.types.str; };
    };
    media.enable = mkEnableOption "media tools";
  };

  config = let cfg = config.modules.programs;
  in lib.mkMerge [
    {
      home.packages = with pkgs; [
        bitwarden-desktop
        obsidian
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

    }

    (lib.mkIf cfg.git.enable {
      programs.git = {
        enable = true;
        lfs.enable = true;
        delta.enable = true;
        inherit (cfg.git) userName userEmail;
        aliases = {
          ci = "commit";
          co = "checkout";
          s = "status";
        };
        extraConfig = {
          init.defaultBranch = "main";
          push = { autoSetupRemote = true; };
          credentials.helper = "store";
          credential.helper = "${
              pkgs.git.override { withLibsecret = true; }
            }/bin/git-credential-libsecret";
          color.ui = true;
        };
        ignores = [ "*~" "*.swp" "*result*" "node_modules" ];
      };
    })

    (lib.mkIf cfg.media.enable {
      home.packages = with pkgs; [ playerctl ];
      programs = {
        imv.enable = true;
        mpv = {
          enable = true;
          defaultProfiles = [ "gpu-hq" ];
          scripts = [ pkgs.mpvScripts.mpris ];
        };
      };
      xdg.mimeApps.defaultApplications = {
        "audio/*" = "mpv.desktop";
        "image/*" = "imv.desktop";
        "video/*" = "mpv.desktop";
      };
    })

  ];
}
