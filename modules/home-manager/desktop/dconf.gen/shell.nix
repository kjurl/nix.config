# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{ lib, ... }:

with lib.hm.gvariant;

{
  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      disabled-extensions = [ "dash-to-panel@jderose9.github.com" "CoverflowAltTab@palatis.blogspot.com" "quick-settings-tweaks@qwreey" "caffeine@patapon.info" "appindicatorsupport@rgcjonas.gmail.com" "gnome-compact-top-bar@metehan-arslan.github.io" "logowidget@github.com.howbea" "tweaks-system-menu@extensions.gnome-shell.fifi.org" "arcmenu@arcmenu.com" "Vitals@CoreCoding.com" "blur-my-shell@aunetx" "space-bar@luchrioh" ];
      enabled-extensions = [ "user-theme@gnome-shell-extensions.gcampax.github.com" "trayIconsReloaded@selfmade.pl" "dash-to-panel@jderose9.github.com" "sound-output-device-chooser@kgshank.net" "clipboard-indicator@tudmotu.com" "color-picker@tuberry" "dash-to-dock@micxgx.gmail.com" "gnome-fuzzy-app-search@gnome-shell-extensions.Czarlie.gitlab.com" "logomenu@aryan_k" "appmenu-is-back@fthx" "forge@jmmaranan.com" "just-perfection-desktop@just-perfection" "AlphabeticalAppGrid@stuarthayhurst" ];
      favorite-apps = [ "firefox.desktop" "org.gnome.Nautilus.desktop" "spotify.desktop" ];
      last-selected-power-profile = "power-saver";
      welcome-dialog-last-shown-version = "47.2";
    };

    "org/gnome/shell/app-switcher" = {
      current-workspace-only = true;
    };

    "org/gnome/shell/extensions/Logo-menu" = {
      hide-forcequit = false;
      hide-icon-shadow = false;
      hide-softwarecentre = true;
      menu-button-icon-image = 18;
      show-activities-button = true;
      show-power-options = false;
      symbolic-icon = false;
      use-custom-icon = false;
    };

    "org/gnome/shell/extensions/alphabetical-app-grid" = {
      folder-order-position = "start";
    };

    "org/gnome/shell/extensions/arcmenu" = {
      arcmenu-hotkey = [ "<Super>z" ];
      button-padding = 1;
      custom-menu-button-icon = "/home/kanishkc/.config/nixos/.github/assets/nixos-logo.png";
      custom-menu-button-icon-size = 25.0;
      dash-to-panel-standalone = false;
      distro-icon = 22;
      force-menu-location = "TopCentered";
      hide-overview-on-startup = true;
      highlight-search-result-terms = true;
      menu-button-appearance = "None";
      menu-button-icon = "Custom_Icon";
      menu-button-left-click-action = "ArcMenu";
      menu-button-position-offset = 0;
      menu-layout = "Default";
      menu-position-alignment = 50;
      multi-monitor = false;
      override-menu-theme = false;
      position-in-panel = "Left";
      prefs-visible-page = 0;
      recently-installed-apps = [];
      runner-hotkey = [ "<Super>a" ];
      runner-search-display-style = "Grid";
      runner-show-frequent-apps = false;
      search-entry-border-radius = mkTuple [ true 25 ];
      search-provider-open-windows = true;
      search-provider-recent-files = true;
      show-activities-button = true;
      show-search-result-details = true;
    };

    "org/gnome/shell/extensions/blur-my-shell" = {
      settings-version = 2;
    };

    "org/gnome/shell/extensions/blur-my-shell/appfolder" = {
      brightness = 0.6;
      sigma = 30;
    };

    "org/gnome/shell/extensions/blur-my-shell/applications" = {
      blur = false;
      blur-on-overview = false;
      brightness = 1.0;
      dynamic-opacity = true;
      enable-all = true;
      opacity = 245;
      sigma = 10;
    };

    "org/gnome/shell/extensions/blur-my-shell/coverflow-alt-tab" = {
      pipeline = "pipeline_default";
    };

    "org/gnome/shell/extensions/blur-my-shell/dash-to-dock" = {
      blur = true;
      brightness = 0.6;
      override-background = true;
      pipeline = "pipeline_default_rounded";
      sigma = 30;
      static-blur = true;
      style-dash-to-dock = 0;
    };

    "org/gnome/shell/extensions/blur-my-shell/lockscreen" = {
      pipeline = "pipeline_default";
    };

    "org/gnome/shell/extensions/blur-my-shell/overview" = {
      pipeline = "pipeline_default";
    };

    "org/gnome/shell/extensions/blur-my-shell/panel" = {
      brightness = 0.6;
      pipeline = "pipeline_default";
      sigma = 30;
      static-blur = true;
    };

    "org/gnome/shell/extensions/blur-my-shell/screenshot" = {
      pipeline = "pipeline_default";
    };

    "org/gnome/shell/extensions/blur-my-shell/window-list" = {
      brightness = 0.6;
      sigma = 30;
    };

    "org/gnome/shell/extensions/caffeine" = {
      indicator-position-max = 2;
    };

    "org/gnome/shell/extensions/clipboard-indicator" = {
      disable-down-arrow = true;
      display-mode = 0;
      history-size = 10;
    };

    "org/gnome/shell/extensions/color-picker" = {
      color-history = [ (mkUint32 0) 1383203 6397930 6397930 6397930 2021216 ];
      menu-style = false;
    };

    "org/gnome/shell/extensions/coverflowalttab" = {
      position = "Top";
      switcher-background-color = mkTuple [ 0.803922 0.839216 0.956863 ];
      switcher-style = "Coverflow";
    };

    "org/gnome/shell/extensions/dash-to-dock" = {
      apply-custom-theme = false;
      apply-glossy-effect = false;
      background-opacity = 0.8;
      custom-background-color = false;
      custom-theme-customize-running-dots = false;
      custom-theme-running-dots-border-color = "rgb(255,255,255)";
      custom-theme-running-dots-color = "rgb(255,255,255)";
      custom-theme-shrink = true;
      dash-max-icon-size = 48;
      disable-overview-on-startup = true;
      dock-fixed = false;
      dock-position = "BOTTOM";
      height-fraction = 0.9;
      hot-keys = false;
      icon-size-fixed = true;
      intellihide-mode = "FOCUS_APPLICATION_WINDOWS";
      preferred-monitor = -2;
      preferred-monitor-by-connector = "eDP-1";
      preview-size-scale = 0.0;
      running-indicator-dominant-color = true;
      running-indicator-style = "DOTS";
      scroll-action = "cycle-windows";
      show-apps-always-in-the-edge = false;
      show-show-apps-button = false;
      show-trash = false;
      show-windows-preview = true;
      transparency-mode = "DEFAULT";
      unity-backlit-items = false;
    };

    "org/gnome/shell/extensions/dash-to-panel" = {
      available-monitors = [ 0 ];
      primary-monitor = 0;
    };

    "org/gnome/shell/extensions/forge" = {
      css-last-update = mkUint32 37;
      css-updated = "1738423196080";
      dnd-center-layout = "swap";
      float-always-on-top-enabled = true;
      focus-border-toggle = false;
      move-pointer-focus-enabled = false;
      preview-hint-enabled = false;
      quick-settings-enabled = true;
      stacked-tiling-mode-enabled = false;
      tabbed-tiling-mode-enabled = false;
      tiling-mode-enabled = true;
      window-gap-hidden-on-single = false;
      window-gap-size = mkUint32 2;
      window-gap-size-increment = mkUint32 1;
    };

    "org/gnome/shell/extensions/forge/keybindings" = {
      con-split-horizontal = [ "<Super>z" ];
      con-split-layout-toggle = [ "<Super>g" ];
      con-split-vertical = [ "<Super>v" ];
      con-stacked-layout-toggle = [ "<Shift><Super>s" ];
      con-tabbed-layout-toggle = [ "<Shift><Super>t" ];
      con-tabbed-showtab-decoration-toggle = [ "<Control><Alt>y" ];
      focus-border-toggle = [ "<Super>x" ];
      mod-mask-mouse-tile = "None";
      prefs-tiling-toggle = [ "<Super>w" ];
      window-focus-down = [ "<Super>j" ];
      window-focus-left = [ "<Super>h" ];
      window-focus-right = [ "<Super>l" ];
      window-focus-up = [ "<Super>k" ];
      window-gap-size-decrease = [ "<Control><Super>minus" ];
      window-gap-size-increase = [ "<Control><Super>plus" ];
      window-move-down = [ "<Shift><Super>j" ];
      window-move-left = [ "<Shift><Super>h" ];
      window-move-right = [ "<Shift><Super>l" ];
      window-move-up = [ "<Shift><Super>k" ];
      window-resize-bottom-decrease = [ "<Shift><Control><Super>i" ];
      window-resize-bottom-increase = [ "<Control><Super>u" ];
      window-resize-left-decrease = [ "<Shift><Control><Super>o" ];
      window-resize-left-increase = [ "<Control><Super>y" ];
      window-resize-right-decrease = [ "<Shift><Control><Super>y" ];
      window-resize-right-increase = [ "<Control><Super>o" ];
      window-resize-top-decrease = [ "<Shift><Control><Super>u" ];
      window-resize-top-increase = [ "<Control><Super>i" ];
      window-snap-center = [ "<Control><Alt>c" ];
      window-snap-one-third-left = [ "<Control><Alt>d" ];
      window-snap-one-third-right = [ "<Control><Alt>g" ];
      window-snap-two-third-left = [ "<Control><Alt>e" ];
      window-snap-two-third-right = [ "<Control><Alt>t" ];
      window-swap-down = [ "<Control><Super>j" ];
      window-swap-last-active = [ "<Super>Return" ];
      window-swap-left = [ "<Control><Super>h" ];
      window-swap-right = [ "<Control><Super>l" ];
      window-swap-up = [ "<Control><Super>k" ];
      window-toggle-always-float = [ "<Shift><Super>c" ];
      window-toggle-float = [ "<Super>c" ];
      workspace-active-tile-toggle = [ "<Shift><Super>w" ];
    };

    "org/gnome/shell/extensions/gsconnect" = {
      id = "aa16aeeb-ab3f-4779-8515-e660ecacb852";
      name = "di15-7567g";
      show-indicators = true;
    };

    "org/gnome/shell/extensions/gsconnect/preferences" = {
      window-maximized = false;
      window-size = mkTuple [ 954 990 ];
    };

    "org/gnome/shell/extensions/just-perfection" = {
      accent-color-icon = false;
      accessibility-menu = true;
      animation = 2;
      background-menu = true;
      controls-manager-spacing-size = 0;
      dash = true;
      dash-icon-size = 0;
      double-super-to-appgrid = true;
      invert-calendar-column-items = false;
      looking-glass-height = 0;
      max-displayed-search-results = 0;
      osd = true;
      overlay-key = true;
      panel = true;
      panel-button-padding-size = 0;
      panel-icon-size = 0;
      panel-in-overview = true;
      panel-indicator-padding-size = 1;
      panel-size = 0;
      ripple-box = true;
      search = true;
      show-apps-button = true;
      startup-status = 0;
      theme = false;
      window-demands-attention-focus = false;
      window-maximized-on-create = false;
      window-picker-icon = true;
      window-preview-caption = true;
      window-preview-close-button = true;
      workspace = true;
      workspace-background-corner-size = 0;
      workspace-peek = false;
      workspace-popup = true;
      workspace-switcher-should-show = false;
      workspace-switcher-size = 0;
      workspaces-in-app-grid = true;
    };

    "org/gnome/shell/extensions/logo-widget" = {
      logo-file = "/home/kanishkc/.config/nixos/.github/assets/nixos-logo.png";
      logo-file-dark = "/home/kanishkc/.config/nixos/.github/assets/nixos-logo.png";
      logo-opacity = mkUint32 18;
      logo-position = "bottom-right";
      logo-size = 2.0;
      overview-visible = true;
    };

    "org/gnome/shell/extensions/space-bar/appearance" = {
      active-workspace-border-radius = 15;
      active-workspace-border-width = 255;
      application-styles = ".space-bar {n  -natural-hpadding: 0px;n}nn.space-bar-workspace-label.active {n  margin: 0 0px;n  background-color: rgba(255,255,255,0.3);n  color: rgba(255,255,255,1);n  border-color: rgba(0,0,0,0);n  font-weight: 700;n  border-radius: 15px;n  border-width: 255px;n  padding: 3px 8px;n}nn.space-bar-workspace-label.inactive {n  margin: 0 0px;n  background-color: rgba(0,0,0,0);n  color: rgba(255,255,255,1);n  border-color: rgba(0,0,0,0);n  font-weight: 700;n  border-radius: 15px;n  border-width: 255px;n  padding: 3px 8px;n}nn.space-bar-workspace-label.inactive.empty {n  margin: 0 0px;n  background-color: rgba(0,0,0,0);n  color: rgba(255,255,255,0.5);n  border-color: rgba(0,0,0,0);n  font-weight: 700;n  border-radius: 15px;n  border-width: 255px;n  padding: 3px 8px;n}";
      empty-workspace-border-radius = 15;
      empty-workspace-border-width = 255;
      inactive-workspace-border-radius = 15;
      inactive-workspace-border-width = 255;
      workspace-margin = 0;
      workspaces-bar-padding = 0;
    };

    "org/gnome/shell/extensions/space-bar/behavior" = {
      always-show-numbers = false;
      indicator-style = "workspaces-bar";
      position = "left";
      scroll-wheel = "panel";
      show-empty-workspaces = false;
      smart-workspace-names = false;
      toggle-overview = false;
    };

    "org/gnome/shell/extensions/space-bar/shortcuts" = {
      enable-move-to-workspace-shortcuts = true;
    };

    "org/gnome/shell/extensions/space-bar/state" = {
      version = 32;
    };

    "org/gnome/shell/extensions/trayIconsReloaded" = {
      applications = "[]";
      tray-position = "right";
    };

    "org/gnome/shell/extensions/tweaks-system-menu" = {
      applications = [ "org.gnome.tweaks.desktop" "org.gnome.Extensions.desktop" ];
      position = -1;
    };

    "org/gnome/shell/extensions/user-theme" = {
      name = "Stylix";
    };

    "org/gnome/shell/extensions/vitals" = {
      alphabetize = true;
      fixed-widths = true;
      hide-icons = true;
      hide-zeros = true;
      icon-style = 1;
      include-static-gpu-info = false;
      menu-centered = false;
      position-in-panel = 2;
      show-battery = true;
      show-gpu = true;
      show-system = false;
      show-temperature = true;
      update-time = 5;
      use-higher-precision = false;
    };

    "org/gnome/shell/keybindings" = {
      switch-to-application-1 = [];
      switch-to-application-2 = [];
      switch-to-application-3 = [];
      switch-to-application-4 = [];
      switch-to-application-5 = [];
      toggle-application-view = [ "<Super>r" ];
    };

    "org/gnome/shell/world-clocks" = {
      locations = [];
    };

  };
}
