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
      kanata-keybd.enable = false;
      mac-randomize.enable = false;
      polkit-gnome.enable = true;
      printing.enable = false;
      samba.enable = false;
      ssh.enable = false;
      usb.enable = false;
      vpn.enable = false;
    };

    system = {
      gaming.enable = true;
      desktop = {
        enable = true;
        # displayManager.greetd.enable = true;
        # displayManager.greetd.flavour = "tui"; # TODO
      };
      virtualisation = {
        enable = true;
        podman.enable = true;
      };
    };
  };
}
