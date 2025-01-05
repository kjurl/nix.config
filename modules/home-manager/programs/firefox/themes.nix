{ lib, pkgs, config, ... }:
let
  kys = lib.utils.findKys ./. ++ [ "themes" ];
  themes = {
    "gnome-theme" = {
      target = ".mozilla/firefox/default/chrome/firefox-gnome-theme";
      source = pkgs.fetchFromGitHub {
        owner = "rafaelmardojai";
        repo = "firefox-gnome-theme";
        rev = "28b913d79d1419585e0f3fc783f5728cd6200347";
        hash = "sha256-wRN87/3VO48XDxasaYwrMtrJIvUPIAg0KLIBpp8SOFc=";
      };
    };
    "modblur-theme" = {
      target = ".mozilla/firefox/default/chrome";
      source = pkgs.fetchFromGitHub {
        owner = "datguypiko";
        repo = "Firefox-Mod-Blur";
        rev = "a4c7cea478c423a9ab4e8b31d0b464f0bc76ac79";
        hash = "sha256-vd+h2CzAcrh2u0+Y5hAJTQj6p/cXT3hWdxLhF+fViRU=";
        postFetch = # bash
          ''
            file_paths=(
              "EXTRA THEMES/MicaForEveryone/acrylic_micaforeveryone.css"
              "EXTRA MODS/Auto hide Mods/Popout bookmarks bar/popout_bookmarks_bar_on_hover.css"
              "EXTRA MODS/Bookmarks Bar Mods/Remove folder icons from bookmars/remove_folder_icons_from_bookmarks.css"
              "EXTRA MODS/Bookmarks Bar Mods/Transparent bookmarks bar/transparent_bookmarks_bar.css"
              "EXTRA MODS/Compact extensions menu/Style 2/cleaner_extensions_menu.css"
              "EXTRA MODS/Homepage mods/Remove text from homepage shortcuts/remove_homepage_shortcut_title_text.css"
              "EXTRA MODS/Icon and Button Mods/Firefox view icon change/firefox_view_icon_change.css"
              "EXTRA MODS/Icon and Button Mods/Hide list-all-tabs button/hide_list-all-tabs_button.css"
              "EXTRA MODS/Icon and Button Mods/Icons in main menu/icons_in_main_menu.css"
              "EXTRA MODS/Icon and Button Mods/Menu icon change/menu_icon_change_to_firefox.css"
              "EXTRA MODS/Search Bar Mods/Search box - no border/url_bar_no_border.css"
              "EXTRA MODS/Search Bar Mods/Search box - transparent background/search_bar_transparent_background.css"
              "EXTRA MODS/Tabs Bar Mods/Colored sound playing tab/colored_soundplaying_tab.css"
              "EXTRA MODS/Tabs Bar Mods/Full Width Tabs/tabs_take_full_bar_width.css"
              "EXTRA MODS/Tabs Bar Mods/Tabs - transparent background color/transparent_tabs_bg_color.css"
            )

            for relative_path in "''${file_paths[@]}"; do
              src="$out/$relative_path"
              cp "$src" "$out/"
            done
          '';
      };
    };
  };
in {
  options = lib.utils.setOptions kys {
    enable = lib.mkEnableOption "firefox-themes";
    name = lib.mkOption { type = lib.types.enum (lib.attrNames themes); };
  };
  config = let cfg = lib.utils.getConfig config kys;
  in lib.mkIf cfg.enable {
    home.file = lib.mkMerge [
      { "firefox-${cfg.name}" = themes."${cfg.name}"; }
      (lib.mkIf (cfg.name == "gnome-theme") {
        ".mozilla/firefox/default/chrome/userChrome.css".text = # css
          ''@import "firefox-gnome-theme/userChrome.css"'';
        ".mozilla/firefox/default/chrome/userContent.css".text = # css
          ''@import "firefox-gnome-theme/userContent.css"'';
      })
    ];

    programs.firefox.profiles.default = {
      settings = {
        "gnome-theme" = {
          "browser.tabs.loadInBackground" = true;
          "svg.context-properties.content.enabled" = true;
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "widget.gtk.rounded-bottom-corners.enabled" = true;

          "gnomeTheme.bookmarksToolbarUnderTabs" = true;
          "gnomeTheme.hideSingleTab" = true;
          "gnomeTheme.normalWidthTabs" = false;
          "gnomeTheme.tabsAsHeaderbar" = false;

          extraConfig = lib.strings.split "\n" (builtins.readFile
            "${themes.gnome-theme.source}/configuration/user.js");
        };
        "modblur-theme" = {
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        };
      }."${cfg.name}";
    };
  };
}
