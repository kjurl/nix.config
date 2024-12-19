{ lib, pkgs, inputs, config, username, ... }: {
  options.modules.system.desktop = {
    enable = lib.mkEnableOption "desktop functionality";
    displayManager.greetd = {
      enable = lib.mkEnableOption "greetd wayland functionality";
      flavour = lib.mkOption {
        type = lib.types.enum [ "tui" "regreet" ];
        default = "tui";
      };
    };
  };

  config = let
    inherit (lib) mkIf mkForce mkMerge;
    inherit (config.modules.core) homeManager;
    inherit (homeConfig.programs) hyprlock;
    cfg = config.modules.system.desktop;
    homeConfig = config.home-manager.users.${username};
    homeDesktopCfg = homeConfig.modules.desktop;
    windowManager =
      if homeManager.enable then homeDesktopCfg.windowManager else null;
    desktopEnvironment =
      if homeManager.enable then homeDesktopCfg.desktopEnvironment else null;
    hyprlandPackage = inputs.hyprland.packages."${pkgs.system}".hyprland;
  in mkIf cfg.enable (mkMerge [
    (mkIf (desktopEnvironment == "gnome") {
      services.xserver = {
        enable = true;
        displayManager.gdm.enable = true;
        desktopManager.gnome.enable = true;
      };
      environment = {
        systemPackages = with pkgs; [
          morewaita-icon-theme
          qogir-icon-theme
          gnome-extension-manager
          wl-clipboard
        ];

        gnome.excludePackages = with pkgs; [
          # gnome-text-editor
          gnome-console
          gnome-initial-setup
          gnome-shell-extensions
          snapshot

          yelp # Help view
          gnome-connections
          gnome-characters
          gnome-font-viewer
          gnome-contacts
          gnome-maps
          epiphany # web browser
          geary # email reader
          evince # document viewer
          gedit

          gnome-photos
          gnome-music
          cheese # webcam tool
          totem # video player

          gnome-tour
          tali # poker game
          iagno # go game
          hitori # sudoku game
          atomix # puzzle game
        ];
      };
    })

    (mkIf cfg.displayManager.greetd.enable {
      # https://www.reddit.com/r/NixOS/comments/u0cdpi/tuigreet_with_xmonad_how/
      systemd.services.greetd.serviceConfig = {
        Type = "idle";
        StandardInput = "tty";
        StandardOutput = "tty";
        StandardError = "journal"; # Without this errors will spam on screen
        # Without these bootlogs will spam on screen
        TTYReset = true;
        TTYVHangup = true;
        TTYVTDisallocate = true;
      };

      # https://github.com/sjcobb2022/nixos-config/blob/29077cee1fc82c5296908f0594e28276dacbe0b0/hosts/common/optional/greetd.nix
      services.greetd = {
        enable = true;
        settings = {
          default_session = {
            command = {
              "tui" =
                "${pkgs.greetd.tuigreet}/bin/tuigreet --time --time-format '%I:%M %p | %a . %h | %F' --remember --cmd Hyprland";
            }."${cfg.displayManager.greetd.flavour}";
            user = "kanishkc";
          };
        };
      };
      environment.etc."greetd/environments".text = ''
        Hyprland
        bash
      '';
    })

    (mkIf homeManager.enable {
      xdg.portal.enable = mkForce false;
      security.pam.services.hyprlock = mkIf hyprlock.enable { };
    })
    (mkIf (windowManager == "Hyprland") {
      programs.hyprland = {
        enable = true;
        package = hyprlandPackage;
      };
    })
    {
      # Enables wayland for all apps that support it
      environment.sessionVariables.NIXOS_OZONE_WL = "1";
      environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";
    }
  ]);
}
