# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{ lib, ... }:

with lib.hm.gvariant;

{
  dconf.settings = {
    "org/gnome/desktop/a11y/applications" = {
      screen-keyboard-enabled = false;
    };

    "org/gnome/desktop/a11y/interface" = {
      show-status-shapes = false;
    };

    "org/gnome/desktop/a11y/keyboard" = {
      bouncekeys-enable = false;
      stickykeys-enable = false;
    };

    "org/gnome/desktop/app-folders" = {
      folder-children = [ "Utilities" "YaST" "Pardus" ];
    };

    "org/gnome/desktop/app-folders/folders/Pardus" = {
      categories = [ "X-Pardus-Apps" ];
      name = "X-Pardus-Apps.directory";
      translate = true;
    };

    "org/gnome/desktop/app-folders/folders/Utilities" = {
      apps = [ "org.freedesktop.GnomeAbrt.desktop" "nm-connection-editor.desktop" "org.gnome.baobab.desktop" "org.gnome.Connections.desktop" "org.gnome.DejaDup.desktop" "org.gnome.DiskUtility.desktop" "org.gnome.Evince.desktop" "org.gnome.FileRoller.desktop" "org.gnome.font-viewer.desktop" "org.gnome.Loupe.desktop" "org.gnome.seahorse.Application.desktop" "org.gnome.tweaks.desktop" "org.gnome.Usage.desktop" ];
      categories = [ "X-GNOME-Utilities" ];
      name = "X-GNOME-Utilities.directory";
      translate = true;
    };

    "org/gnome/desktop/app-folders/folders/YaST" = {
      categories = [ "X-SuSE-YaST" ];
      name = "suse-yast.directory";
      translate = true;
    };

    "org/gnome/desktop/background" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri = "file:///nix/store/f61kgkdmvzk0qlylfqvbr21j6sx4ggsj-wallpaper-nix-black-4k.png";
      picture-uri-dark = "file:///nix/store/f61kgkdmvzk0qlylfqvbr21j6sx4ggsj-wallpaper-nix-black-4k.png";
    };

    "org/gnome/desktop/calendar" = {
      show-weekdate = false;
    };

    "org/gnome/desktop/input-sources" = {
      sources = [ (mkTuple [ "xkb" "en" ]) ];
      xkb-options = [ "terminate:ctrl_alt_bksp" ];
    };

    "org/gnome/desktop/interface" = {
      clock-format = "12h";
      clock-show-date = true;
      clock-show-seconds = false;
      clock-show-weekday = true;
      color-scheme = "default";
      cursor-size = 24;
      cursor-theme = "Bibata-Modern-Ice";
      document-font-name = "Ubuntu Sans  11";
      enable-animations = true;
      font-name = "Ubuntu Sans 12";
      gtk-theme = "adw-gtk3";
      icon-theme = "Adwaita";
      monospace-font-name = "JetBrainsMono Nerd Font 12";
      overlay-scrolling = true;
      show-battery-percentage = false;
      toolkit-accessibility = false;
    };

    "org/gnome/desktop/media-handling" = {
      autorun-never = false;
    };

    "org/gnome/desktop/notifications" = {
      application-children = [ "firefox" ];
    };

    "org/gnome/desktop/notifications/application/firefox" = {
      application-id = "firefox.desktop";
    };

    "org/gnome/desktop/peripherals/keyboard" = {
      delay = mkUint32 186;
      numlock-state = true;
    };

    "org/gnome/desktop/peripherals/keyboard/delay" = {
      uint32 = 180;
    };

    "org/gnome/desktop/peripherals/touchpad" = {
      tap-to-click = true;
      two-finger-scrolling-enabled = true;
    };

    "org/gnome/desktop/privacy" = {
      recent-files-max-age = 7;
      remove-old-temp-files = true;
      remove-old-trash-files = true;
    };

    "org/gnome/desktop/search-providers" = {
      disabled = [ "org.gnome.Boxes.desktop" ];
      enabled = [ "org.gnome.Weather.desktop" ];
      sort-order = [ "org.gnome.Contacts.desktop" "org.gnome.Documents.desktop" "org.gnome.Nautilus.desktop" "org.gnome.Calendar.desktop" "org.gnome.Calculator.desktop" "org.gnome.Software.desktop" "org.gnome.Settings.desktop" "org.gnome.clocks.desktop" "org.gnome.design.IconLibrary.desktop" "org.gnome.seahorse.Application.desktop" "org.gnome.Weather.desktop" "org.gnome.Boxes.desktop" ];
    };

    "org/gnome/desktop/session" = {
      idle-delay = mkUint32 0;
    };

    "org/gnome/desktop/sound" = {
      event-sounds = true;
      theme-name = "__custom";
    };

    "org/gnome/desktop/wm/keybindings" = {
      close = [ "<Super>q" ];
      move-to-workspace-1 = [ "<Super><Shift>1" ];
      move-to-workspace-10 = [ "<Super><Shift>0" ];
      move-to-workspace-2 = [ "<Super><Shift>2" ];
      move-to-workspace-3 = [ "<Super><Shift>3" ];
      move-to-workspace-4 = [ "<Super><Shift>4" ];
      move-to-workspace-5 = [ "<Super><Shift>5" ];
      move-to-workspace-6 = [ "<Super><Shift>6" ];
      move-to-workspace-7 = [ "<Super><Shift>7" ];
      move-to-workspace-8 = [ "<Super><Shift>8" ];
      move-to-workspace-9 = [ "<Super><Shift>9" ];
      switch-to-workspace-1 = [ "<Super>1" ];
      switch-to-workspace-2 = [ "<Super>2" ];
      switch-to-workspace-3 = [ "<Super>3" ];
      switch-to-workspace-4 = [ "<Super>4" ];
      switch-to-workspace-5 = [ "<Super>5" ];
      toggle-fullscreen = [ "<Super>g" ];
    };

    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu";
      focus-mode = "sloppy";
      mouse-button-modifier = "<Super>";
      num-workspaces = 6;
      resize-with-right-button = true;
      visual-bell = false;
      visual-bell-type = "fullscreen-flash";
    };

  };
}
