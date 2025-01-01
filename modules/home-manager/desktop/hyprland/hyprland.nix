{ lib, pkgs, config, osConfig, ... }:
let
  desktopCfg = config.modules.desktop;
  osDesktopEnabled = osConfig.modules.system.desktop.enable;
  hyprland = config.wayland.windowManager.hyprland.package;
  ops = { fcitx5 = false; };

  colors_conf = {
    # general = {
    #   "col.active_border" = "rgba(F7DCDE39)";
    #   "col.inactive_border" = "rgba(A58A8D30)";
    # };

    # misc = { background_color = "rgba(1D1011FF)"; };

    plugin.hyprbars = {
      bar_text_font =
        "Rubik, Geist, AR One Sans, Reddit Sans, Inter, Roboto, Ubuntu, Noto Sans, sans-serif";
      bar_height = 30;
      bar_padding = 10;
      bar_button_padding = 5;
      bar_precedence_over_border = true;
      bar_part_of_window = true;
      # bar_color = "rgba(1D1011FF)";
      # "col.text" = "rgba(F7DCDEFF)";

      # example buttons
      hyprbars-button = [
        {
          # color = "rgb(F7DCDE)";
          size = 13;
          icon = "󰖭";
          command = "hyprctl dispatch killactive";
        }
        {
          # color = "rgb(F7DCDE)";
          size = 13;
          icon = "󰖯";
          command = "hyprctl dispatch fullscreen 1";
        }
        {
          # color = "rgb(F7DCDE)";
          size = 13;
          icon = "󰖰";
          command = "hyprctl dispatch movetoworkspacesilent special";
        }
      ];
    };

    windowrulev2 = "bordercolor rgba(FFB2BCAA) rgba(FFB2BC77),pinned:1";
  };

  exec_conf = {
    exec-once = [
      # Core components
      "gnome-keyring-daemon --start --components=secrets"
      "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 || /usr/libexec/polkit-gnome-authentication-agent-1"
      "hypridle"
      "dbus-update-activation-environment --all"
      "sleep 1 && dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP" # Some fix idk
      "hyprpm reload"

      # Audio
      "easyeffects --gapplication-service"

      # Clipboard: history
      # "wl-paste --watch cliphist store &"
      "wl-paste --type text --watch cliphist store"
      "wl-paste --type image --watch cliphist store"

      # Cursor
      "hyprctl setcursor Bibata-Modern-Classic 24"
    ] ++ lib.optional ops.fcitx5 "fcitx5";
  };

  general_conf = {
    monitor =
      ",preferred,auto,1"; # Custom reserved area can be uncommented if needed

    input = {
      kb_layout = "us";
      # kb_options = "grp:win_space_toggle";
      numlock_by_default = true;
      repeat_delay = 250;
      repeat_rate = 35;

      touchpad = {
        natural_scroll = true;
        disable_while_typing = true;
        clickfinger_behavior = true;
        scroll_factor = 0.5;
      };

      special_fallthrough = true;
      follow_mouse = 1;
    };

    binds = { scroll_event_delay = 0; };

    gestures = {
      workspace_swipe = true;
      workspace_swipe_distance = 700;
      workspace_swipe_fingers = 4;
      workspace_swipe_cancel_ratio = 0.2;
      workspace_swipe_min_speed_to_force = 5;
      workspace_swipe_direction_lock = true;
      workspace_swipe_direction_lock_threshold = 10;
      workspace_swipe_create_new = true;
    };

    general = {
      gaps_in = 4;
      gaps_out = 5;
      gaps_workspaces = 50;
      border_size = 1;

      # "col.active_border" = "rgba(0DB7D4FF)";
      # "col.inactive_border" = "rgba(31313600)";

      resize_on_border = true;
      no_focus_fallback = true;
      layout = "dwindle";

      allow_tearing =
        true; # This just allows the `immediate` window rule to work
    };

    dwindle = {
      preserve_split = true;
      # no_gaps_when_only = 1;
      smart_split = false;
      smart_resizing = false;
    };

    decoration = {
      rounding = 20;

      blur = {
        enabled = true;
        xray = true;
        special = false;
        new_optimizations = true;
        size = 14;
        passes = 4;
        brightness = 1;
        noise = 1.0e-2;
        contrast = 1;
        popups = true;
        popups_ignorealpha = 0.6;
      };

      # drop_shadow = true;
      # shadow_ignore_window = true;
      # shadow_range = 20;
      # shadow_offset = "0 2";
      # shadow_render_power = 4;
      # "col.shadow" = "rgba(0000002A)";

      # screen_shader = "~/.config/hypr/shaders/nothing.frag";
      # screen_shader = "~/.config/hypr/shaders/vibrance.frag";

      dim_inactive = false;
      dim_strength = 0.1;
      dim_special = 0;
    };

    animations = {
      enabled = true;
      first_launch_animation = true;
      bezier = [
        "linear, 0, 0, 1, 1"
        "md3_standard, 0.2, 0, 0, 1"
        "md3_decel, 0.05, 0.7, 0.1, 1"
        "md3_accel, 0.3, 0, 0.8, 0.15"
        "overshot, 0.05, 0.9, 0.1, 1.1"
        "crazyshot, 0.1, 1.5, 0.76, 0.92"
        "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
        "menu_decel, 0.1, 1, 0, 1"
        "menu_accel, 0.38, 0.04, 1, 0.07"
        "easeInOutCirc, 0.85, 0, 0.15, 1"
        "easeOutCirc, 0, 0.55, 0.45, 1"
        "easeOutExpo, 0.16, 1, 0.3, 1"
        "softAcDecel, 0.26, 0.26, 0.15, 1"
        "md2, 0.4, 0, 0.2, 1" # use with .2s duration
      ];

      animation = [
        "windows, 1, 3, md3_decel, popin 60%"
        "windowsIn, 1, 3, md3_decel, popin 60%"
        "windowsOut, 1, 3, md3_accel, popin 60%"
        "border, 1, 10, default"
        "fade, 1, 3, md3_decel"
        "layersIn, 1, 3, menu_decel, slide"
        "layersOut, 1, 1.6, menu_accel"
        "fadeLayersIn, 1, 2, menu_decel"
        "fadeLayersOut, 1, 4.5, menu_accel"
        "workspaces, 1, 7, menu_decel, slide"
        "specialWorkspace, 1, 3, md3_decel, slidevert"
      ];
    };

    misc = {
      vfr = 1;
      vrr = 1;
      animate_manual_resizes = false;
      animate_mouse_windowdragging = false;
      enable_swallow = false;
      swallow_regex = "(foot|kitty|allacritty|Alacritty)";

      disable_hyprland_logo = true;
      force_default_wallpaper = 0;
      new_window_takes_over_fullscreen = 2;
      allow_session_lock_restore = true;

      initial_workspace_tracking = false;
    };

    # Overview
    plugin = {
      hyprexpo = {
        columns = 3;
        gap_size = 5;
        bg_col = "rgb(000000)";
        workspace_method =
          "first 1"; # [center/first] [workspace] e.g. first 1 or center m+1

        enable_gesture = false; # laptop touchpad, 4 fingers
        gesture_distance = 300; # how far is the "max"
        gesture_positive = false;
      };
    };
  };

  rules_conf = {
    # Window rules
    windowrule = [
      # https://github.com/RustLover2910/dotsnix/blob/64c05e65b7bcfd27b8fad1bddca5113ed2523175/modules/home/hyprland/config.nix#L235     
      "float, ^(Motrix)"
      "float, ^(pwvucontrol)"
      "noblur,.*"
      # "opacity 0.89 override 0.89 override, .*" # Applies transparency to EVERY WINDOW
      "float, ^(blueberry.py)$"
      "float, ^(steam)$"
      "float, ^(guifetch)$" # FlafyDev/guifetch
      "center, title:^(Open File)(.*)$"
      "center, title:^(Select a File)(.*)$"
      "center, title:^(Choose wallpaper)(.*)$"
      "center, title:^(Open Folder)(.*)$"
      "center, title:^(Save As)(.*)$"
      "center, title:^(Library)(.*)$"
      "center, title:^(File Upload)(.*)$"
      "float,title:^(Open File)(.*)$"
      "float,title:^(Select a File)(.*)$"
      "float,title:^(Choose wallpaper)(.*)$"
      "float,title:^(Open Folder)(.*)$"
      "float,title:^(Save As)(.*)$"
      "float,title:^(Library)(.*)$"
      "float,title:^(File Upload)(.*)$"
      "immediate,.*\\.exe"
      "immediate,class:(steam_app)"
      "noshadow,floating:0"
    ];

    # Layer rules
    layerrule = [
      "xray 1, .*"
      # "noanim, .*"
      "noanim, walker"
      "noanim, selection"
      "noanim, overview"
      "noanim, indicator.*"
      "noanim, osk"
      "noanim, hyprpicker"
      "blur, shell:*"
      "ignorealpha 0.6, shell:*"
      "noanim, noanim"
      "blur, gtk-layer-shell"
      "ignorezero, gtk-layer-shell"
      "blur, launcher"
      "ignorealpha 0.5, launcher"
      "blur, notifications"
      "ignorealpha 0.69, notifications"
      "animation slide top, sideleft.*"
      "animation slide top, sideright.*"
      "blur, session"
      "blur, bar"
      "ignorealpha 0.6, bar"
      "blur, corner.*"
      "ignorealpha 0.6, corner.*"
      "blur, dock"
      "ignorealpha 0.6, dock"
      "blur, indicator.*"
      "ignorealpha 0.6, indicator.*"
      "blur, overview"
      "ignorealpha 0.6, overview"
      "blur, cheatsheet"
      "ignorealpha 0.6, cheatsheet"
      "blur, sideright"
      "ignorealpha 0.6, sideright"
      "blur, sideleft"
      "ignorealpha 0.6, sideleft"
      "blur, indicator*"
      "ignorealpha 0.6, indicator*"
      "blur, osk"
      "ignorealpha 0.6, osk"
    ];
  };
in lib.mkIf (osDesktopEnabled && desktopCfg.windowManager == "Hyprland") {
  modules.programs.hyprlock.enable = true;
  xdg.portal = {
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
    configPackages = [ hyprland ];
  };

  wayland.windowManager.hyprland = {
    enable = true;
    # plugins = [ inputs.hypr-space.packages.${pkgs.system}.Hyprspace ];
    settings = { } // colors_conf // {
      env = [
        # ############ Themes #############
        "QT_QPA_PLATFORM=wayland"
        "QT_QPA_PLATFORMTHEME=qt5ct"
        "QT_STYLE_OVERRIDE=kvantum"
        "WLR_NO_HARDWARE_CURSORS=1"

        # ######## Screen tearing #########
        "WLR_DRM_NO_ATOMIC=1"

        # ############ Others #############
      ] ++ lib.optionals ops.fcitx5 [
        "INPUT_METHOD=fcitx"
        # https://wiki.archlinux.org/title/Fcitx5#IM_modules
        "GTK_IM_MODULE=fcitx"
        "QT_IM_MODULE=fcitx"
        "SDL_IM_MODULE=fcitx"
        "GLFW_IM_MODULE=ibus"
        # https://wiki.archlinux.org/title/Fcitx5#XIM
        "XMODIFIERS=@im=fcitx"
      ];
    } // exec_conf // general_conf // rules_conf;
    xwayland.enable = true;
  };
}
