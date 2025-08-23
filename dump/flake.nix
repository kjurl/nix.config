# TODO: add semver that auto generates changelog
{
  description = "Personal Nix configurations";

  nixConfig = {
    extra-substituters = [
      "https://cache.nixos.org/"
      "https://nix-community.cachix.org"
      "https://foo-dogsquared.cachix.org"
    ];
    extra-trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "foo-dogsquared.cachix.org-1:/2fmqn/gLGvCs5EDeQmqwtus02TUmGy0ZlAEXqRE70E="
    ];
    commit-lockfile-summary = "flake.lock: update inputs";
  };

  inputs = {
    root = {
      url = "file+file:///dev/null";
      flake = false;
    };
    # Official NixOS package source
    # using nixos's stable branch by default
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    nixpkgs.follows = "nixpkgs-stable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixwsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur.url = "github:nix-community/NUR";
    devenv.url = "github:cachix/devenv";

    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts.url = "github:hercules-ci/flake-parts";

    impermanence.url = "github:nix-community/impermanence";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    haumea = {
      url = "github:nix-community/haumea/v0.2.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix2container.url = "github:nlewo/nix2container";
    nix2container.inputs.nixpkgs.follows = "nixpkgs";
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
      inputs.flake-parts.follows = "flake-parts";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "git+https://github.com/hyprwm/hyprland?submodules=1";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.hyprland.follows = "hyprland";
    };
    winapps = {
      url = "github:winapps-org/winapps/feat-nix-packaging";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    gitignore.url = "github:hercules-ci/gitignore.nix";
    gitignore.inputs.nixpkgs.follows = "nixpkgs";
    Hyprspace = {
      url = "github:KZDKM/Hyprspace";
      inputs.hyprland.follows = "hyprland";
    };
    Hyprlux = {
      url = "github:amadejkastelic/Hyprlux";
      inputs.nixpkgs.follows = "hyprland/nixpkgs";
    };
    Hyprkool = {
      url = "github:thrombe/hyprkool";
      inputs.nixpkgs.follows = "hyprland/nixpkgs";
      inputs.hyprland.follows = "hyprland";
    };
    stylix = {
      url = "github:danth/stylix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        # home-manager.follows = "home-manager";
      };
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # WINDOW MANAGER PROGRAMS
    # anyrun.url = "github:anyrun-org/anyrun";
    # anyrun.inputs.nixpkgs.follows = "nixpkgs";
    # walker.url = "github:abenz1267/walker";
    # walker.inputs.nixpkgs.follows = "nixpkgs";
    # PROGRAMS
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    spicetify-nix.inputs.nixpkgs.follows = "nixpkgs";
    vencord-nix.url = "github:kaylorben/nixcord";
    vencord-nix.inputs.nixpkgs.follows = "nixpkgs";
    mechabar = {
      url = "github:sejjy/mechabar";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, flake-parts, ... }@inputs:
    let
      specialArgs = rec {
        outputs = self.outputs;
        libx = import ./libraries nixpkgs.lib;
        lib =
          nixpkgs.lib.extend (final: _prev: libx // inputs.home-manager.lib);
      };
    in flake-parts.lib.mkFlake { inherit inputs specialArgs; } {

      imports = with inputs; [ devenv.flakeModule ./modules/flake-parts ];

      systems = [ "x86_64-linux" "aarch64-darwin" ];

      _module.args = {
        lib = nixpkgs.lib.extend
          (final: _prev: (import ../libraries) // inputs.home-manager.lib);

        # This will be shared among NixOS and home-manager configurations.
        defaultNixConf = { config, lib, pkgs, ... }: {
          # Extend nixpkgs with our overlays except for the NixOS-focused modules
          # here.
          nixpkgs.overlays = lib.attrValues inputs.self.overlays
            ++ [ inputs.wrapper-manager-fds.overlays.default ];
        };

        defaultOverlays = nixpkgs.lib.attrValues inputs.self.overlays;

        defaultSystems = [ "x86_64-linux" ];
      };
    };
}
