{ lib, pkgs, config, osConfig, ... }:
lib.mkIf osConfig.modules.system.desktop.enable {
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

  # TODO: enable stylix in nixos modules
  # stylix.fonts = {
  #   monospace = {
  #     name = "JetBrainsMono Nerd Font";
  #     package = pkgs.nerd-fonts.jetbrains-mono;
  #   };
  #   sansSerif = {
  #     name = "Ubuntu Sans";
  #     package = pkgs.nerd-fonts.ubuntu-sans;
  #   };
  # serif = config.stylix.fonts.sansSerif;
  # };

}
