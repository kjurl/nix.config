{ lib, ... }:
let inherit (lib) utils mkEnableOption;
in {
  imports = utils.scanPaths ./.;

  options.modules.services = {
    gnome-keyring.enable = mkEnableOption "gnome keyring";
    kanata-keybd.enable = mkEnableOption "kanata keyboard";
    mac-randomize.enable = mkEnableOption "macchanger";
    polkit-gnome.enable = mkEnableOption "gnome polkit";
    printing.enable = mkEnableOption "printing";
    samba.enable = mkEnableOption "samba";
    ssh.enable = mkEnableOption "ssh";
    usb.enable = mkEnableOption "usb";
    vpn.enable = mkEnableOption "vpn";
  };

  config = {
    services = {
      tumbler.enable = true;
      gvfs.enable = true;
    };
  };
}
