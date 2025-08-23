{ lib, pkgs, inputs, config, username, ... }:
lib.x.options.auto ./. config [ "wsl" ] (cfg: {
  imports = [ inputs.nixwsl.nixosModules.wsl ];
  options.enable = lib.mkEnableOption "wsl";
  config = lib.mkIf cfg.enable {
    wsl = {
      enable = true;
      wslConf = {
        automount.root = "/mnt";
        interop.appendWindowsPath = false;
        network.generateHosts = false;
      };

      defaultUser = username;
      startMenuLaunchers = true;
    };

    environment = {
      enableAllTerminfo = true;
      systemPackages = [ pkgs.wslu ];
    };
    security.sudo.wheelNeedsPassword = false;

  };
})
