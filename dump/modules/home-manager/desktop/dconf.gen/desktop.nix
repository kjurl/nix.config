# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{ lib, ... }:

with lib.hm.gvariant;

{
  dconf.settings = {
    "org/gnome/desktop/a11y" = { always-show-universal-access-status = false; };

    "org/gnome/desktop/a11y/applications" = {
      screen-keyboard-enabled = false;
    };

    "org/gnome/desktop/a11y/interface" = { show-status-shapes = false; };

    "org/gnome/desktop/a11y/keyboard" = {
      bouncekeys-enable = false;
      stickykeys-enable = false;
    };

    "org/gnome/desktop/app-folders" = {
      folder-children = [
        "Utilities"
        "2a505edf-510b-4a3f-aa2b-caab96f97ca6"
        "869ec47d-e8ef-4463-82cc-4ebace8b8902"
      ];
    };

    "org/gnome/desktop/app-folders/folders/2a505edf-510b-4a3f-aa2b-caab96f97ca6" =
      {
        apps = [
          "cmd.desktop"
          "explorer.desktop"
          "powershell-ide.desktop"
          "powershell.desktop"
          "windows.desktop"
        ];
        name = "Windows";
        translate = false;
      };

    "org/gnome/desktop/app-folders/folders/444d9613-38e4-4994-94f4-eed2730ad57b" =
      {
        apps = [
          "access.desktop"
          "excel-o365.desktop"
          "onenote-o365.desktop"
          "outlook-o365.desktop"
          "powerpoint-o365.desktop"
          "word-o365.desktop"
        ];
        name = "Office";
      };

    "org/gnome/desktop/app-folders/folders/869ec47d-e8ef-4463-82cc-4ebace8b8902" =
      {
        apps = [
          "access.desktop"
          "excel-o365.desktop"
          "onenote-o365.desktop"
          "outlook-o365.desktop"
          "powerpoint-o365.desktop"
          "word-o365.desktop"
        ];
        name = "Office";
      };

    "org/gnome/desktop/app-folders/folders/Utilities" = {
      apps = [
        "org.gnome.baobab.desktop"
        "org.gnome.DiskUtility.desktop"
        "org.gnome.Evince.desktop"
        "org.gnome.FileRoller.desktop"
        "org.gnome.Loupe.desktop"
        "org.gnome.seahorse.Application.desktop"
        "org.gnome.tweaks.desktop"
        "org.freedesktop.GnomeAbrt.desktop"
        "nm-connection-editor.desktop"
        "org.gnome.Connections.desktop"
        "org.gnome.DejaDup.desktop"
        "org.gnome.font-viewer.desktop"
        "org.gnome.Usage.desktop"
      ];
      categories = [ "X-GNOME-Utilities" ];
      name = "X-GNOME-Utilities.directory";
      translate = true;
    };

    "org/gnome/desktop/background" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri =
        "file:///nix/store/zrvky5rs9rzbwhdff37j8vv1l49z516n-wallpaper.jpg";
      picture-uri-dark =
        "file:///nix/store/zrvky5rs9rzbwhdff37j8vv1l49z516n-wallpaper.jpg";
    };

    "org/gnome/desktop/calendar" = { show-weekdate = false; };

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

    "org/gnome/desktop/media-handling" = { autorun-never = false; };

    "org/gnome/desktop/notifications" = {
      application-children = [
        "firefox"
        "org-gnome-fileroller"
        "org-gnome-baobab"
        "gnome-power-panel"
        "org-gnome-nautilus"
      ];
    };

    "org/gnome/desktop/notifications/application/firefox" = {
      application-id = "firefox.desktop";
    };

    "org/gnome/desktop/notifications/application/gnome-power-panel" = {
      application-id = "gnome-power-panel.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-baobab" = {
      application-id = "org.gnome.baobab.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-fileroller" = {
      application-id = "org.gnome.FileRoller.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-nautilus" = {
      application-id = "org.gnome.Nautilus.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-systemmonitor" = {
      application-id = "org.gnome.SystemMonitor.desktop";
    };

    "org/gnome/desktop/peripherals/keyboard" = {
      delay = mkUint32 186;
      numlock-state = true;
    };

    "org/gnome/desktop/peripherals/keyboard/delay" = { uint32 = 180; };

    "org/gnome/desktop/peripherals/mouse" = { accel-profile = "flat"; };

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
      sort-order = [
        "org.gnome.Contacts.desktop"
        "org.gnome.Documents.desktop"
        "org.gnome.Nautilus.desktop"
        "org.gnome.Calendar.desktop"
        "org.gnome.Calculator.desktop"
        "org.gnome.Software.desktop"
        "org.gnome.Settings.desktop"
        "org.gnome.clocks.desktop"
        "org.gnome.design.IconLibrary.desktop"
        "org.gnome.seahorse.Application.desktop"
        "org.gnome.Weather.desktop"
        "org.gnome.Boxes.desktop"
      ];
    };

    "org/gnome/desktop/session" = { idle-delay = mkUint32 0; };

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
