{ lib, pkgs, config, osConfig, ... }:
lib.mkIf osConfig.modules.system.desktop.enable {
  # fonts.fontconfig.enable = true;
  home.packages = with pkgs;
    with nerd-fonts; [
      adwaita-icon-theme
      papirus-icon-theme

      cantarell-fonts
      font-awesome
      jetbrains-mono
      cascadia-code
      fira-mono
      fira-code
    ];
  stylix.fonts = {
    monospace = {
      # name = "JetBrainsMono Nerd Font";
      # package = pkgs.nerd-fonts.override { fonts = [ "JetBrainsMono" ]; };
      name = "Ubuntu Sans Mono";
      package = pkgs.nerd-fonts.ubuntu-mono;
    };
    sansSerif = {
      name = "Ubuntu Sans";
      package = pkgs.nerd-fonts.ubuntu-sans;
    };
    serif = config.stylix.fonts.sansSerif;
  };

}
