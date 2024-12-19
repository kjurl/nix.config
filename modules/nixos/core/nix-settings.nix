{ lib, config, inputs, outputs, ... }:
let inherit (lib) isType mapAttrs filterAttrs mapAttrsToList;
in {
  system.autoUpgrade = {
    enable = true;
    operation = "switch";
    flake = inputs.self.outPath;
    flags = [ "--update-input" "nixpkgs" "--commit-lock-file" ];
    dates = "weekly";
  };

  nixpkgs = {
    overlays = [
      inputs.hyprpanel.overlay
      # outputs.overlays.additions
      # outputs.overlays.modifications
      # outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    config.allowUnfree = true;
  };

  nix = let flakeInputs = filterAttrs (_: isType "flake") inputs;
  in {
    channel.enable = false;
    # Populates the nix registry with all our flake inputs `nix registry list`
    registry = mapAttrs (_: flake: { inherit flake; }) flakeInputs;
    # Add flake inputs to nix path. Enables loading flakes with <flake_name>
    # like how <nixpkgs> can be referenced.
    # nixPath = (mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs)
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
    settings = {
      # https://discourse.nixos.org/t/declaratively-or-otherwise-add-trusted-users-in-21-11/25134/2
      trusted-users = [ "root" "@wheel" ];
      experimental-features = [ "nix-command" "flakes" "pipe-operators" ];
      # Do not load the default global registry
      # https://channels.nixos.org/flake-registry.json
      flake-registry = "";
      # Workaround for https://github.com/NixOS/nix/issues/9574
      nix-path = config.nix.nixPath;
      auto-optimise-store = true;
      warn-dirty = false;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
    optimise.automatic = true;
  };
}
