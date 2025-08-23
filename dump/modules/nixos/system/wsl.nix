{ lib, pkgs, inputs, config, username, ... }: {
  imports = [ inputs.nixwsl.nixosModules.wsl ];
  options.modules.system.wsl = { enable = lib.mkEnableOption "wsl"; };
  config = lib.mkIf config.modules.system.wsl.enable {
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
}
