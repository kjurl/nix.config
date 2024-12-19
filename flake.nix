{
  outputs = { self, nixpkgs, ... }@inputs:
    let
      inherit (self) outputs;
      lP = nixpkgs.legacyPackages;
      lib = nixpkgs.lib.extend (final: _prev:
        (import ./libraries.nix final) // inputs.home-manager.lib);
      systems = [ "aarch64-linux" "x86_64-linux" "aarch64-darwin" ];
      forAllSystems = lib.genAttrs systems;
      mkHost = hostname: username: system: {
        ${hostname} = lib.nixosSystem {
          inherit system;
          specialArgs = { inherit self inputs outputs hostname username lib; };
          modules = if (lib.hasPrefix "installer" hostname) then
            [ ./systems/installer ]
          else [
            ./systems/${hostname}
            ./modules/nixos
          ];
        };
      };
    in {
      checks = forAllSystems (system: {
        lint-check = let pkgs = import nixpkgs { inherit system; };
        in pkgs.runCommandLocal "lint-check" {
          src = ./.;
          nativeBuildInputs = with pkgs; [ statix deadnix ];
        } # bash
        ''
          statix check
          deadnix
        '';
      });
      formatter = forAllSystems (system: lP.${system}.nixfmt-classic);
      packages = forAllSystems (system: import ./packages lP.${system});
      libraries = lib;
      nixosModules.modules = import ./modules/nixos; # upstream into nixpkgs
      homeManagerModules.modules =
        import ./modules/home-manager; # upstream into hm
      nixosConfigurations = mkHost "di15-7567g" "kanishkc" "x86_64-linux";
    };
  inputs = {
    # Core
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    haumea = {
      url = "github:nix-community/haumea/v0.2.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    winapps = {
      url = "github:winapps-org/winapps/feat-nix-packaging";
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
    ironBar = {
      url = "github:JakeStanger/ironbar";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    gBar = {
      url = "github:scorpion-26/gBar";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
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
    anyrun = {
      url = "github:anyrun-org/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    walker = {
      url = "github:abenz1267/walker";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
