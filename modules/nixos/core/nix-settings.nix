{ lib, config, inputs, outputs, ... }:
let flakeInputs = lib.attrsets.filterAttrs (_: lib.isType "flake") inputs;
in {
  nixpkgs = {
    overlays = [
      inputs.nur.overlays.default
      outputs.overlays.default
      # (_final: prev: {
      #   unstable = import nixpkgs-unstable {
      #     inherit (prev) system;
      #     inherit config;
      #   };
      # })
    ];
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [ ];
    };
  };
  nix = {
    channel.enable = false;
    # Populates the nix registry with all our flake inputs `nix registry list`
    registry = lib.attrsets.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
    # Add flake inputs to nix path. Enables loading flakes with <flake_name>
    # like how <nixpkgs> can be referenced.
    nixPath =
      (lib.attrsets.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs)
      ++ [ "nixpkgs=${inputs.nixpkgs}" ];
    settings = {
      # https://discourse.nixos.org/t/declaratively-or-otherwise-add-trusted-users-in-21-11/25134/2
      trusted-users = [ "root" "@wheel" ];
      experimental-features = [ "nix-command" "flakes" ];
      # Do not load the default global registry
      # https://channels.nixos.org/flake-registry.json
      flake-registry = "";
      # Workaround for https://github.com/NixOS/nix/issues/9574
      nix-path = config.nix.nixPath;
      accept-flake-config = true;
      auto-optimise-store = true;
      warn-dirty = false;
    };
    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };
    optimise.automatic = true;
  };
}
