{ lib, config, ... }:

lib.mkIf (!config.modules.system.wsl.enable) {
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 3000 ];
    allowedUDPPorts = [ 3000 ];
  };
}
