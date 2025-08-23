{ lib, config, username, hostname, ... }:
lib.mkMerge [
  {
    networking.hostName = hostname;
    users.users.${username}.extraGroups = [ "networkmanager" ];
  }

  (lib.mkUnlessWsl config {
    networking = {
      networkmanager.enable = true;
      useDHCP = false;

      # Enable Encrypted DNS
      nameservers = [ "127.0.0.1" "::1" ];
      networkmanager.dns = "none";
    };

    # KDE Connect firewall rules
    networking.firewall = rec {
      allowedTCPPortRanges = [{
        from = 1714;
        to = 1764;
      }];
      allowedUDPPortRanges = allowedTCPPortRanges;
    };

    # dnscrypt-proxy
    services.dnscrypt-proxy2 = {
      enable = true;
      settings = {
        ipv6_servers = true;
        require_dnssec = true;

        sources.public-resolvers = {
          urls = [
            "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
            "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
          ];
          cache_file = "/var/lib/dnscrypt-proxy2/public-resolvers.md";
          minisign_key =
            "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
        };

        server_names = [
          "cloudflare"
          "cloudflare-ipv6"
          "cloudflare-security"
          "cloudflare-security-ipv6"
          "adguard-dns-doh"
          "mullvad-adblock-doh"
          "mullvad-doh"
          "nextdns"
          "nextdns-ipv6"
          "quad9-dnscrypt-ipv4-filter-pri"
          "google"
          "google-ipv6"
          "ibksturm"
        ];
      };
    };

    systemd.services.dnscrypt-proxy2.serviceConfig = {
      StateDirectory = "dnscrypt-proxy";
    };
  })
]
