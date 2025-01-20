{ lib, pkgs, config, osConfig, ... }@args:
let
  kys = lib.utils.findKys ./. ++ [ "firefox" ];
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
        hash = "sha256-eeUZFx0PdbVYsaB8vLLh7nWMI1NHgcY/jQtymGjQbFk=";
        postFetch = # bash
          ''
            file_paths=(
              # "EXTRA THEMES/MicaForEveryone/acrylic_micaforeveryone.css"
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
              if [[ -f "$src" ]]; then
                cp -n "$src" "$out/"
              else
                echo "Warning: File '$src' does not exist, skipping."
              fi
            done
          '';
      };
    };
  };
in {
  options = lib.utils.setOptions kys {
    enable = lib.mkEnableOption "firefox";
    theme = lib.mkOption { type = lib.types.enum (lib.attrNames themes); };
  };
  config = let cfg = lib.utils.getConfig config kys;
  in lib.mkIf cfg.enable {

    home.sessionVariables = { BROWSER = "firefox"; };

    home.file = lib.mkMerge [
      { "firefox-${cfg.theme}" = themes."${cfg.theme}"; }
      (lib.mkIf (cfg.theme == "gnome-theme") {
        ".mozilla/firefox/default/chrome/userChrome.css".text = # css
          ''@import "firefox-gnome-theme/userChrome.css"'';
        ".mozilla/firefox/default/chrome/userContent.css".text = # css
          ''@import "firefox-gnome-theme/userContent.css"'';
      })
    ];

    programs.firefox = {
      enable = true;
      # ---- POLICIES ----
      # Check about:policies#documentation for options.
      # ---- EXTENSIONS ----
      # Check about:support for extension/add-on ID strings.
      # Valid strings for installation_mode are "allowed", "blocked",
      # "force_installed" and "normal_installed".
      policies = {
        # InstallAddonsPermission = { Default = false; };
        # BlockAboutAddons = true;
        # BlockAboutConfig = true;
        BlockAboutProfiles = true;

        DisableFormHistory = true;
        DisableFirefoxAccounts = true;
        # NetworkPrediction = false;

        UserMessaging = {
          WhatsNew = false;
          UrlbarInterventions = false;
          FeatureRecommendations = false;
          MoreFromMozilla = false;
          SkipOnboarding = true;
        };

        DisableFirefoxStudies = true;
        DisableTelemetry = true;
        DisablePocket = true;
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };

        HardwareAcceleration = true;
        AutofillAddressEnabled = false;
        AutofillCreditCardEnabled = false;
        OfferToSaveLogins = false;
        PasswordManagerEnabled = false;
        FirefoxHome = {
          Search = true;
          Pocket = false;
          Snippets = false;
          TopSites = false;
          Highlights = false;
        };
      };

      profiles = {
        default = {
          id = 0;
          name = "default";
          isDefault = true;
          search = {
            force = true;
            default = "DuckDuckGo";
            engines = let
              engine = { aliases ? [ ], params ? [ ], icon ?
                  "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg"
                }: {
                  definedAliases = aliases;
                  urls = let
                    splitToSublistsAcc = acc: key:
                      if lib.strings.hasInfix "://" key then
                        acc ++ [ [ key ] ]
                      else
                        lib.pipe key [
                          (y: (lib.lists.last acc) ++ [ y ])
                          (y: (lib.lists.init acc) ++ [ y ])
                        ];

                    stringToAttrset = str:
                      let parts = lib.strings.splitString ":" str;
                      in if builtins.length parts == 2 then
                        let psElem = builtins.elemAt parts;
                        in {
                          name = psElem 0;
                          value = psElem 1;
                        }
                      else
                        null;

                    subLists = lib.lists.foldl splitToSublistsAcc [ ] params;
                    final = map (sublist: {
                      template = lib.lists.take 1 sublist;
                      params = map stringToAttrset (lib.lists.drop 1 sublist);
                    }) subLists;

                  in lib.attrsets.filterAttrs (e: e != null) final;

                  inherit icon;
                };
            in {
              "Bing".metaData.hidden = true;
              "Wikipedia".metaData.hidden = true;
              "Nix Packages" = {
                urls = [{
                  template = "https://search.nixos.org/packages";
                  params = [
                    {
                      name = "type";
                      value = "packages";
                    }
                    {
                      name = "channel";
                      value = "unstable";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }];
                icon =
                  "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = [ "@np" ];
              };
              "Nix Packages Versions" = {
                urls = [{
                  template = "https://lazamar.co.uk/nix-versions/";
                  params = [
                    {
                      name = "channel";
                      value = "nixpkgs-unstable";
                    }
                    {
                      name = "package";
                      value = "{searchTerms}";
                    }
                  ];
                }];
                icon =
                  "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = [ "@npv" ];
              };
              "Home-manager Options" = {
                urls = [{
                  template = "https://home-manager-options.extranix.com";
                  params = [
                    {
                      name = "release";
                      value = "master";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }];
                icon =
                  "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = [ "@hm" ];
              };
              "NixOS Wiki" = {
                urls = [{
                  template = "https://wiki.nixos.org/index.php";
                  params = [{
                    name = "query";
                    value = "{searchTerms}";
                  }];
                }];
                icon =
                  "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = [ "@nw" ];
              };
            };
          };

          # https://gitlab.com/rycee/nur-expressions/-/blob/master/pkgs/firefox-addons/addons.json?ref_type=heads
          extensions = with lib.utils.flakePkgs args "firefox-addons"; [
            ublock-origin
            sponsorblock
            bitwarden
            raindropio

            # multi-account-containers
            # proton-vpn
            # containerise
          ];
          settings = {
            # For Firefox GNOME theme:
            "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
            "browser.tabs.drawInTitlebar" = true;
            ## Firefox gnome theme ## - https://github.com/rafaelmardojai/firefox-gnome-theme/blob/7cba78f5216403c4d2babb278ff9cc58bcb3ea66/configuration/user.js
            # (copied into here because home-manager already writes to user.js)
            "browser.uidensity" = 0; # Set UI density to normal
            "svg.context-properties.content.enabled" =
              true; # Enable SVG context-propertes
            "browser.theme.dark-private-windows" =
              false; # Disable private window dark theme

            # General
            "general.autoScroll" = true;
            "extensions.pocket.enabled" = false;
            # Enable userChrome.css modifications
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
            # Enable hardware acceleration
            # Firefox only support VAAPI acceleration. This is natively supported
            # by AMD cards but NVIDIA cards need a translation library to go from
            # VDPAU to VAAPI.
            "media.ffmpeg.vaapi.enabled" =
              osConfig.modules.hardware.graphics.nvidia.enable;

            # UI
            "browser.newtabpage.activity-stream.feeds.system.topstories" =
              false;
            "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts" =
              false;
            "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts.searchEngines" =
              "";
            "browser.startup.page" = 3;
            "browser.toolbars.bookmarks.visibility" = "never";

            # QOL
            "browser.aboutConfig.showWarning" = false;
            "doms.forms.autocomplete.formautofill" = false;
            "extensions.formautofill.creditCards.enabled" = false;
            "identity.fxaccounts.enabled" = false;
            "signon.management.page.breach-alerts.enabled" = false;

            # Privacy
            "browser.newtabpage.activity-stream.default.sites" = "";
            "browser.newtabpage.activity-stream.feeds.telemetry" = false;
            "browser.newtabpage.activity-stream.showSponsored" = false;
            "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
            "browser.newtabpage.activity-stream.telemetry" = false;
            "browser.ping-centre.telemetry" = false;
            "breakpad.reportURL" = "";
            "browser.tabs.crashReporting.sendReport" = false;
            "browser.crashReports.unsubmittedCheck.autoSubmit2" = false;
            "captivedetect.canonicalURL" = "";
            "datareporting.policy.dataSubmissionEnabled" = false;
            "datareporting.healthreport.uploadEnabled" = false;
            "dom.security.https_only_mode" = true;
            "extensions.htmlaboutaddons.recommendations.enabled" = false;
            "browser.discovery.enabled" = false;
            "network.captive-portal-service.enabled" = false;
            "network.connectivity-service.enabled" = false;
            "network.trr.mode" = 3;
            "network.trr.uri" = "https://dns.quad9.net/dns-query";
            "privacy.trackingprotection.enabled" = true;
            "private.donottrackheader.enabled" = true;
            "private.globalprivacycontrol.enabled" = true;
            "signon.rememberSignons" = false;
            "toolkit.coverage.endpoint.base" = "";
            "toolkit.coverage.opt-out" = true;
            "toolkit.telemetry.archive.enabled" = false;
            "toolkit.telemetry.bhrPing.enabled" = false;
            "toolkit.telemetry.enabled" = false;
            "toolkit.telemetry.firstShutdownPing.enabled" = false;
            "toolkit.telemetry.newProfilePing.enabled" = false;
            "toolkit.telemetry.server" = "data:,";
            "toolkit.telemetry.shutdownPingSender.enabled" = false;
            "toolkit.telemetry.unified" = false;
            "toolkit.telemetry.updatePing.enabled" = false;

            # Don't report TLS errors to Mozilla
            "security.ssl.errorReporting.enabled" = false;

            # Disable Pocket integration
            "browser.pocket.enabled" = false;
            # "extensions.pocket.enabled" = false;

            # Disable More from Mozilla
            "browser.preferences.moreFromMozilla" = false;

            # Do not show unicode urls https://www.xudongz.com/blog/2017/idn-phishing/
            "network.IDN_show_punycode" = true;

            # Disable screenshots extension
            "extensions.screenshots.disabled" = true;

            # Disable onboarding
            "browser.onboarding.newtour" =
              "performance,private,addons,customize,default";
            "browser.onboarding.updatetour" =
              "performance,library,singlesearch,customize";
            "browser.onboarding.enabled" = false;

            # Disable recommended extensions
            "extensions.htmlaboutaddons.discover.enabled" = false;
            # "extensions.htmlaboutaddons.recommendations.enabled" = false;

            # Disable use of WiFi region/location information
            # "browser.region.network.scan" = false;
            # "browser.region.network.url" = "";
            # "browser.region.update.enabled" = false;

            # Disable VPN/mobile promos
            "browser.contentblocking.report.hide_vpn_banner" = true;
            "browser.contentblocking.report.mobile-ios.url" = "";
            "browser.contentblocking.report.mobile-android.url" = "";
            "browser.contentblocking.report.show_mobile_app" = false;
            "browser.contentblocking.report.vpn.enabled" = false;
            "browser.contentblocking.report.vpn.url" = "";
            "browser.contentblocking.report.vpn-promo.url" = "";
            "browser.contentblocking.report.vpn-android.url" = "";
            "browser.contentblocking.report.vpn-ios.url" = "";
            "browser.privatebrowsing.promoEnabled" = false;
          } // {
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
          }."${cfg.theme}";
        };
      };
    };

    xdg.mimeApps.defaultApplications = {
      "text/html" = [ "firefox.desktop" ];
      "text/xml" = [ "firefox.desktop" ];
      "x-scheme-handler/http" = [ "firefox.desktop" ];
      "x-scheme-handler/https" = [ "firefox.desktop" ];
    };
  };
}
