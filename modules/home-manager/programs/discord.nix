{ lib, config, inputs, ... }:
let kys = lib.utils.findKys ./. ++ [ "discord" ];
in {
  imports = [ inputs.vencord-nix.homeManagerModules.nixcord ];
  options = lib.utils.setOptions kys { enable = lib.mkEnableOption "discord"; };
  config = let cfg = lib.utils.getConfig config kys;
  in lib.mkIf cfg.enable {
    programs.nixcord = {
      enable = true; # enable Nixcord. Also installs discord package
      # quickCss = "some CSS"; # quickCSS file
      config = {
        useQuickCss = true; # use out quickCSS
        # themeLinks = [ # or use an online theme
        #   "https://raw.githubusercontent.com/link/to/some/theme.css"
        # ];
        frameless = true; # set some Vencord options
        plugins = {
          hideAttachments.enable = true; # Enable a Vencord plugin
          # ignoreActivities = { # Enable a plugin and set some options
          #   enable = true;
          #   ignorePlaying = true;
          #   ignoreWatching = true;
          #   ignoredActivities = [ "someActivity" ];
          # };
        };
      };
      extraConfig = {
        # Some extra JSON config here
        # ...
      };
    };
  };
}
