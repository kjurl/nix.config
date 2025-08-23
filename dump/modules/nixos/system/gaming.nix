{ lib, config, ... }: {
  options.modules.system.gaming = {
    enable = lib.mkEnableOption "gaming packages";
  };
  config = let cfg = config.modules.system.gaming;
  in lib.mkIf cfg.enable {
    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
  };
}
