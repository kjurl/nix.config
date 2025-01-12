{ lib, pkgs, inputs, username, ... }: {
  imports = lib.utils.scanPaths ./. ++ [ inputs.sops-nix.nixosModules.sops ];
  config = {
    environment.systemPackages = with pkgs; [
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

    users.groups.uinput.members = [ username ];
    users.groups.input.members = [ username ];

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
