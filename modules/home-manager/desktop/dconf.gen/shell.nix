# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{ lib, ... }:

with lib.hm.gvariant;

{
  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      disabled-extensions = [ "dash-to-panel@jderose9.github.com" "CoverflowAltTab@palatis.blogspot.com" "quick-settings-tweaks@qwreey" "caffeine@patapon.info" ];
      enabled-extensions = [ "user-theme@gnome-shell-extensions.gcampax.github.com" "trayIconsReloaded@selfmade.pl" "Vitals@CoreCoding.com" "dash-to-panel@jderose9.github.com" "sound-output-device-chooser@kgshank.net" "space-bar@luchrioh" ];
      favorite-apps = [ "firefox.desktop" "org.gnome.Nautilus.desktop" "org.gnome.Calendar.desktop" "obsidian.desktop" "transmission-gtk.desktop" "caprine.desktop" "teams-for-linux.desktop" "discord.desktop" "spotify.desktop" "com.usebottles.bottles.desktop" "org.gnome.Software.desktop" ];
      welcome-dialog-last-shown-version = "47.2";
    };

    "org/gnome/shell/app-switcher" = {
      current-workspace-only = true;
    };

    "org/gnome/shell/extensions/Logo-menu" = {
      menu-button-icon-image = 18;
      symbolic-icon = false;
      use-custom-icon = false;
    };

    "org/gnome/shell/extensions/arcmenu" = {
      arcmenu-hotkey = [ "<Super>z" ];
      button-padding = 1;
      custom-menu-button-icon = "/home/kanishkc/.config/nixos/.github/assets/nixos-logo.png";
      custom-menu-button-icon-size = 25.0;
      dash-to-panel-standalone = false;
      distro-icon = 22;
      hide-overview-on-startup = true;
      menu-button-appearance = "None";
      menu-button-icon = "Custom_Icon";
      menu-button-position-offset = 0;
      menu-layout = "Default";
      menu-position-alignment = 50;
      multi-monitor = false;
      position-in-panel = "Left";
      prefs-visible-page = 0;
      runner-hotkey = [ "<Super>a" ];
      search-entry-border-radius = mkTuple [ true 25 ];
    };

    "org/gnome/shell/extensions/blur-my-shell" = {
      settings-version = 2;
    };

    "org/gnome/shell/extensions/blur-my-shell/appfolder" = {
      brightness = 0.6;
      sigma = 30;
    };

    "org/gnome/shell/extensions/blur-my-shell/coverflow-alt-tab" = {
      pipeline = "pipeline_default";
    };

    "org/gnome/shell/extensions/blur-my-shell/dash-to-dock" = {
      blur = true;
      brightness = 0.6;
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

    "org/gnome/shell/extensions/coverflowalttab" = {
      position = "Top";
      switcher-background-color = mkTuple [ 0.803921568627451 0.8392156862745098 0.9568627450980393 ];
      switcher-style = "Coverflow";
    };

    "org/gnome/shell/extensions/dash-to-panel" = {
      available-monitors = [ 0 ];
      primary-monitor = 0;
    };

    "org/gnome/shell/extensions/forge" = {
      css-last-update = mkUint32 37;
      dnd-center-layout = "swap";
      move-pointer-focus-enabled = false;
      preview-hint-enabled = false;
      stacked-tiling-mode-enabled = false;
      tabbed-tiling-mode-enabled = false;
      tiling-mode-enabled = true;
      window-gap-size = mkUint32 2;
    };

    "org/gnome/shell/extensions/forge/keybindings" = {
      con-split-horizontal = [ "<Super>z" ];
      con-split-layout-toggle = [ "<Super>g" ];
      con-split-vertical = [ "<Super>v" ];
      con-stacked-layout-toggle = [ "<Shift><Super>s" ];
      con-tabbed-layout-toggle = [ "<Shift><Super>t" ];
      con-tabbed-showtab-decoration-toggle = [ "<Control><Alt>y" ];
      focus-border-toggle = [ "<Super>x" ];
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

    "org/gnome/shell/extensions/logo-widget" = {
      logo-file = "/home/kanishkc/.config/nixos/.github/assets/nixos-logo.png";
      logo-file-dark = "/home/kanishkc/.config/nixos/.github/assets/nixos-logo.png";
      logo-opacity = mkUint32 18;
      logo-position = "bottom-right";
      logo-size = 2.0;
      overview-visible = true;
    };

    "org/gnome/shell/extensions/space-bar/appearance" = {
      application-styles = ".space-bar {n  -natural-hpadding: 0px;n}nn.space-bar-workspace-label.active {n  margin: 0 0px;n  background-color: rgba(255,255,255,0.3);n  color: rgba(255,255,255,1);n  border-color: rgba(0,0,0,0);n  font-weight: 700;n  border-radius: 4px;n  border-width: 0px;n  padding: 3px 8px;n}nn.space-bar-workspace-label.inactive {n  margin: 0 0px;n  background-color: rgba(0,0,0,0);n  color: rgba(255,255,255,1);n  border-color: rgba(0,0,0,0);n  font-weight: 700;n  border-radius: 4px;n  border-width: 0px;n  padding: 3px 8px;n}nn.space-bar-workspace-label.inactive.empty {n  margin: 0 0px;n  background-color: rgba(0,0,0,0);n  color: rgba(255,255,255,0.5);n  border-color: rgba(0,0,0,0);n  font-weight: 700;n  border-radius: 4px;n  border-width: 0px;n  padding: 3px 8px;n}";
      workspace-margin = 0;
      workspaces-bar-padding = 0;
    };

    "org/gnome/shell/extensions/space-bar/behavior" = {
      always-show-numbers = false;
      indicator-style = "workspaces-bar";
      position = "left";
      show-empty-workspaces = false;
      smart-workspace-names = true;
      toggle-overview = false;
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
      hide-icons = false;
      hide-zeros = true;
      icon-style = 1;
      menu-centered = true;
      position-in-panel = 2;
      show-battery = true;
      show-gpu = true;
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
