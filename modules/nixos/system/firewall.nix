{ ... }: {
  # Open ports in the firewall.
  networking = {
    firewall.enable = true;
    firewall.allowedTCPPorts = [ 3000 ];
    firewall.allowedUDPPorts = [ 3000 ];
  };
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}
