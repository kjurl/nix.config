{
  outputs = { self, nixpkgs, flake-parts, ... }@inputs:
    let
      inherit (self) outputs;
      lP = nixpkgs.legacyPackages;
      lib = nixpkgs.lib.extend (final: _prev:
        (import ./libraries.nix final) // inputs.home-manager.lib);
    in flake-parts.lib.mkFlake { inherit inputs; } {
      imports = with inputs; [ devenv.flakeModule nix-topology.flakeModule ];
      perSystem = { config, self', inputs', pkgs, system, ... }: {
        formatter = lP.${system}.nixfmt-classic;
        packages = import ./packages lP.${system};
        checks.lint-check = let pkgs = import nixpkgs { inherit system; };
        in pkgs.runCommandLocal "lint-check" {
          nativeBuildInputs = with pkgs; [ statix deadnix ];
          src = ./.;
        } "statix check; deadnix";
        devenv.shells.default = {
          devenv.root =
            let devenvRootFileContent = builtins.readFile inputs.root.outPath;
            in pkgs.lib.mkIf (devenvRootFileContent != "")
            devenvRootFileContent;
          # https://github.com/cachix/devenv/issues/760
          containers = lib.mkForce { };
          difftastic.enable = true;
          packages = with pkgs; [ just lazygit ];
          languages.nix = {
            enable = true;
            lsp.package = pkgs.nixd;
          };
          pre-commit.hooks.shellcheck.enable = true;
          # See full reference at https://devenv.sh/reference/options/
        };
      };
      flake = {
        libraries = lib;
        nixosModules.modules = import ./modules/nixos; # upstream into nixpkgs
        homeManagerModules = import ./modules/home-manager; # upstream into hm
        nixosConfigurations = let
          mkHost = hostname: username: system: {
            ${hostname} = lib.nixosSystem {
              inherit system;
              specialArgs = {
                inherit self inputs outputs hostname username lib;
              };
              modules = if (lib.hasPrefix "installer" hostname) then
                [ ./systems/installer ]
              else [
                ./systems/${hostname}
                ./modules/nixos
              ];
            };
          };
        in mkHost "di15-7567g" "kanishkc" "x86_64-linux";
      };
      systems = [ "aarch64-linux" "x86_64-linux" "aarch64-darwin" ];
    };

  inputs = {
    root = {
      url = "file+file:///dev/null";
      flake = false;
    };
    # Official NixOS package source, using nixos's unstable branch by default
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    stable.url = "github:nixos/nixpkgs/nixos-24.11";
    impermanence.url = "github:nix-community/impermanence";
    nix-topology.url = "github:oddlama/nix-topology";
    flake-parts.url = "github:hercules-ci/flake-parts";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    haumea.url = "github:nix-community/haumea/v0.2.2";
    haumea.inputs.nixpkgs.follows = "nixpkgs";
    devenv.url = "github:cachix/devenv";
    nix2container.url = "github:nlewo/nix2container";
    nix2container.inputs.nixpkgs.follows = "nixpkgs";
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
      inputs.flake-parts.follows = "flake-parts";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "https://github.com/hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
      submodules = true;
      type = "git";
    };
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
        home-manager.follows = "home-manager";
      };
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # WINDOW MANAGER PROGRAMS
    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
    hyprpanel.inputs.nixpkgs.follows = "nixpkgs";
    anyrun.url = "github:anyrun-org/anyrun";
    anyrun.inputs.nixpkgs.follows = "nixpkgs";
    walker.url = "github:abenz1267/walker";
    walker.inputs.nixpkgs.follows = "nixpkgs";
    # PROGRAMS
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    spicetify-nix.inputs.nixpkgs.follows = "nixpkgs";
    vencord-nix.url = "github:kaylorben/nixcord";
    vencord-nix.inputs.nixpkgs.follows = "nixpkgs";
  };
}
