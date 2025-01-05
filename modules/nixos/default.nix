{ lib, pkgs, inputs, ... }: {
  # imports = let
  #   collectValues = attrs: acc:
  #     builtins.foldl' (acc': value:
  #       if builtins.isAttrs value then
  #         collectValues value acc'
  #       else
  #         acc' ++ [ value ]) acc (builtins.attrValues attrs);
  # in (collectValues (inputs.haumea.lib.load {
  #   src = ./system;
  #   loader = inputs.haumea.lib.loaders.path;
  # }) [ ]) ++ [ inputs.stylix.nixosModules.stylix ];
  imports = lib.utils.scanPaths ./. ++ [ inputs.sops-nix.nixosModules.sops ];
  config = {
    environment.systemPackages = with pkgs; [
      inputs.zen-browser.packages.${pkgs.system}.default
      devenv
      (writeScriptBin "nix-clean" # bash
        ''
          nix-env --delete-generations old
          nix-store --gc
          for link in /nix/var/nix/gcroots/auto/*
          do
            rm $(readlink "$link")
          done
          nix-collect-garbage -d
        '')
    ];
    nix.settings = {
      extra-trusted-public-keys =
        "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=";
      extra-substituters = "https://devenv.cachix.org";
    };

    programs.gamemode.enable = true;
    # services.ratbagd.enable = true;

    # https://github.com/tinted-theming/schemes/tree/spec-0.11/base16

    hardware.uinput.enable = true;
    users.groups.uinput.members = [ "kanishkc" ];
    users.groups.input.members = [ "kanishkc" ];

    # extraGroups = [
    #     "nixosvmtest"
    #     "networkmanager"
    #     "wheel"
    #     "audio"
    #     "video"
    #     "libvirtd"
    #     "docker"
    #   ];
    #
    # make gnome toggelable
    # specialisation = {
    #   gnome.configuration = {
    #     system.nixos.tags = ["Gnome"];
    #     hyprland.enable = lib.mkForce false;
    #     gnome.enable = true;
    #   };
    # };
  };
}
