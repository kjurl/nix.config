{
  imports = [ ./hardware-configuration.nix ];

  modules = {
    core = { homeManager.enable = true; };
    hardware = {
      audio.enable = true;
      bluetooth.enable = true;
      camera.enable = true;
      power.enable = true;
      graphics = {
        enable = true;
        nvidia = {
          enable = true;
          prime = {
            enable = true;
            intelBusId = "PCI:0:02:0";
            nvidiaBusId = "PCI:01:0:0";
          };
        };
      };
    };
    services = {
      gnome-keyring.enable = true;
      mac-randomize.enable = false;
      polkit-gnome.enable = true;
      printing.enable = false;
      ssh.enable = false;
      usb.enable = false;
      vpn.enable = false;
    };
    system = {
      desktop.enable = true;
      # desktop.desktopEnvironment = "gnome";
      desktop.displayManager.greetd.enable = true;
      desktop.displayManager.greetd.flavour = "tui"; # TODO
      virtualisation = {
        enable = true;
        podman.enable = true;
      };
      # audio.enable = true;
      # bluetooth.enable = true;
    };
  };
}
