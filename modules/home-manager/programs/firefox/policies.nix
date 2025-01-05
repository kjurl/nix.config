{ lib, config, ... }:
let kys = lib.utils.findKys ./. ++ [ "policies" ];
in {
  options = lib.utils.setOptions kys {
    enable = lib.mkEnableOption "firefox-policies";
  };
  config = let cfg = lib.utils.getConfig config kys;
  in lib.mkIf cfg.enable {
    # ---- POLICIES ----
    # Check about:policies#documentation for options.
    # ---- EXTENSIONS ----
    # Check about:support for extension/add-on ID strings.
    # Valid strings for installation_mode are "allowed", "blocked",
    # "force_installed" and "normal_installed".
    programs.firefox.policies = {
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
  };
}
