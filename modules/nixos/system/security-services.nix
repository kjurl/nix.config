{ pkgs, lib, ... }: {
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.

  # Enable Security Services
  users.users.root.hashedPassword = "!";

  security = {
    polkit.enable = true;
    tpm2 = {
      enable = true;
      pkcs11.enable = true;
      tctiEnvironment.enable = true;
    };
    apparmor = {
      enable = true;
      packages = with pkgs; [ apparmor-utils apparmor-profiles ];
    };
  };

  services.fail2ban.enable = true;

  programs = {
    browserpass.enable = true;

    firejail = {
      enable = true;
      wrappedBinaries = let
        getWrappedBin = bin: {
          ${bin} = {
            executable = "${lib.getBin pkgs.${bin}}/bin/${bin}";
            profile = "${pkgs.firejail}/etc/firefail/${bin}.profile";
          };
        };
      in lib.lists.foldl' (acc: key: acc // getWrappedBin key) { } [
        "mpv"
        "imv"
        "zathura"
        "vscodium"
      ];
    };

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    mtr.enable = true;
  };
  environment.systemPackages = with pkgs; [
    vulnix # scan command: vulnix --system
    clamav # scan command: sudo freshclam; clamscan [options] [file/directory/-]
    chkrootkit # scan command: sudo chkrootkit

    # passphrase2pgp
    pass-wayland
    pass2csv
    passExtensions.pass-tomb
    passExtensions.pass-update
    passExtensions.pass-otp
    passExtensions.pass-import
    passExtensions.pass-audit
    tomb
  ];
}
