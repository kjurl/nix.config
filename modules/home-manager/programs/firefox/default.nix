{ lib, config, osConfig, ... }@args:
let kys = lib.utils.findKys ./.;
in {
  imports = lib.utils.scanPaths ./.;
  options = lib.utils.setOptions kys { enable = lib.mkEnableOption "firefox"; };
  config = let cfg = lib.utils.getConfig config kys;
  in lib.mkIf cfg.enable {
    home.sessionVariables = { BROWSER = "firefox"; };

    programs.firefox = {
      enable = true;
      profiles = {
        default = {
          id = 0;
          name = "default";
          isDefault = true;

          # https://gitlab.com/rycee/nur-expressions/-/blob/master/pkgs/firefox-addons/addons.json?ref_type=heads
          extensions = with lib.utils.flakePkgs args "firefox-addons"; [
            ublock-origin
            sponsorblock
            bitwarden
            raindropio

            multi-account-containers
            proton-vpn
            containerise
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
          };
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
