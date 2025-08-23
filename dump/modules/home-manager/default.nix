{ lib, pkgs, config, inputs, username, ... }: {
  imports = lib.x.imports.scanPaths ./.;
  options.main = lib.mkOption { type = lib.types.setType; };
  config = {
    home = {
      inherit username;
      homeDirectory = "/home/${username}";
      packages = with pkgs; [
        # bottles
        baobab
        comma
        gnome-disk-utility
        motrix
        nurl

        (writeScriptBin "config" # bash
          "cd ${builtins.readFile inputs.root.outPath} && nvim")

      ];
      sessionPath = [ "$HOME/.local/bin" ];
      sessionVariables = { FLAKE = "/home/${username}/.config/nixos"; };
      # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
      stateVersion = "24.05";
      activation.clean-nixDirectories =
        lib.hm.dag.entryAfter [ "writeBoundary" ] # bash
        ''
          rm -rf ${config.home.homeDirectory}/.nix-defexpr
          rm -rf ${config.home.homeDirectory}/.nix-profile
        '';
    };

    programs.nh = {
      enable = true;
      # clean.enable = true;
      # clean.extraArgs = "--keep-since 4d --keep 3";
      # flake = ../../.;
    };

    xdg.configFile."mimeapps.list".force = true;

    # github:matostitos
    nix.settings = {
      builders-use-substitutes = true;
      substituters = [
        "https://cache.nixos.org"
        "https://nixpkgs-wayland.cachix.org"
        "https://nix-community.cachix.org"
        "https://hyprland.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
    };
    # github:mobsenpai/hana
    systemd.user.startServices = "sd-switch";
  };
}
