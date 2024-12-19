{ lib, config, ... }:
let cfg = config.modules.shell;
in lib.mkIf cfg.enable {
  programs.direnv = {
    enable = true;
    silent = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
    config = {
      global = {
        load_dotennv = true;
        strict_env = true;
        warn_timout = -1;
      };
      whitelist.exact = [ "~/Documents/website" ./. ];
    };
  };
}
