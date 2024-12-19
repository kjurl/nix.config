{ lib, pkgs, config, inputs, ... }:
let inherit (lib) mkEnableOption;
in {
  imports = lib.utils.scanPaths ./.
    ++ [ inputs.spicetify-nix.homeManagerModules.default ];
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
      home.packages = with pkgs; [ bitwarden-desktop obsidian ];
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
        delta.enable = true;
        inherit (cfg.git) userName userEmail;
        extraConfig = {
          init.defaultBranch = "main";
          credentials.helper = "store";
          color.ui = true;
        };
        ignores = [ "*~" "*.swp" "*result*" "node_modules" ];
      };
    })

    (lib.mkIf cfg.media.enable {
      home.packages = with pkgs; [
        playerctl
        # audio control
        pulsemixer
        pwvucontrol
      ];
      programs = {
        imv.enable = true;
        mpv = {
          enable = true;
          defaultProfiles = [ "gpu-hq" ];
          scripts = [ pkgs.mpvScripts.mpris ];
        };
        spicetify =
          let spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
          in {
            enable = true;
            enabledExtensions = with spicePkgs.extensions; [
              adblock
              hidePodcasts
              shuffle # shuffle+
            ];
            # theme = spicePkgs.themes.catppuccin;
            # colorScheme = "mocha";
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
