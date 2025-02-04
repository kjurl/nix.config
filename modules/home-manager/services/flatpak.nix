{ lib, config, inputs, ... }: {

  imports = [ inputs.nix-flatpak.homeManagerModules.nix-flatpak ];

  config = let cfg = config.modules.services.flatpak;
  in lib.mkIf cfg.enable {
    services.flatpak = {
      enable = true;
      uninstallUnmanaged = true;
      remotes = lib.mkOptionDefault [{
        name = "flathub-beta";
        location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo";
      }];
      packages = [ "app.zen_browser.zen" ];
    };
  };
}
