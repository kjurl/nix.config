{ inputs, ... }: {
  imports = [ inputs.hyprpanel.homeManagerModules.hyprpanel ];
  programs.hyprpanel = {
    enable = true;
    # overlay.enable = true;
    systemd.enable = true;
    hyprland.enable = true;
    overwrite.enable = true;
    theme = "catppuccin_mocha";
    layout."bar.layouts" = {
      "*" = {
        left = [ "dashboard" "media" "windowtitle" ];
        middle = [ "workspaces" ];
        right = [
          "volume"
          "network"
          "bluetooth"
          "battery"
          "systray"
          "clock"
          "notifications"
        ];
      };
    };

    # Configure and theme *most* of the options from the GUI.
    # See './nix/module.nix:103'.
    # Default: <same as gui>
    settings = {
      bar = {
        battery.hideLabelWhenFull = true;
        battery.label = true;
        bluetooth.label = false;
        clock.format = "%a %b %d  %I:%M %p";
        clock.showTime = true;
        launcher = { autoDetectIcon = true; };
        workspaces = {
          applicationIconEmptyWorkspace = "";
          applicationIconFallback = "󱃵";
          scroll_speed = 5;
          showAllActive = true;
          showApplicationIcons = true;
          showWsIcons = true;
          show_icons = true;
          show_numbered = false;
          workspaces = 3;
        };
        network = {
          label = false;
          showWifiInfo = false;
          truncation = true;
        };
        volume.label = false;
        windowtitle = {
          custom_title = false;
          class_name = true;
          label = true;
        };
        media.show_active_only = true;
        notifications.show_total = true;
        notifications.hideCountWhenZero = true;
      };
      menus = {
        clock = {
          weather.unit = "metric";
          weather.location = "Delhi";
        };
        dashboard = {
          controls.enabled = false;
          directories.enabled = false;
          shortcuts.enabled = true;
        };
        dashboard.stats.enable_gpu = true;
        media.displayTimeTooltip = false;
        transition = "none";
        # bluetooth.showBattery = true;
      };
      notifications.showActionsOnHover = true;
      scalingPriority = "hyprland";
      theme = {
        bar = {
          border.location = "none";
          transparent = true;
          floating = false;
          location = "top";
          outer_spacing = ".25em";
          border_radius = "0.4em";
          buttons = {
            enableBorders = false;
            dashboard.enableBorder = false;
            modules.ram.enableBorder = false;
            systray.enableBorder = true;
            volume.enableBorder = false;
            windowtitle.enableBorder = false;
            workspaces.fontSize = "1.2em";
            y_margins = "0.4em";
            padding_x = "0.7rem";
            radius = "0.3em";
          };
        };
        font = {
          name = "UbuntuSans Nerd Font";
          size = "0.8rem";
          weight = 400;
        };
        osd = {
          location = "bottom";
          muted_zero = true;
          orientation = "horizontal";
        };
      };
    };
  };
}
