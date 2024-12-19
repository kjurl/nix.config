{ lib, config, ... }:
let cfg = config.modules.hardware.bluetooth;
in {
  options.modules.hardware.bluetooth.enable = lib.mkEnableOption "bluetooth";
  config = lib.mkIf cfg.enable {
    hardware.bluetooth.enable = true;
    hardware.bluetooth.settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        Experimental = true;
      };
    };
    services.blueman.enable = true;
  };
}
