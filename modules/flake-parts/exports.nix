{ libx, inputs, ... }: {
  perSystem = { pkgs, self, inputs, system, ... }: {
    # packages = import ../../packages pkgs;
  };

  # flake = let secrets = builtins.fromJSON(builtins.readFile"${self}/secrets.json"); in {
  flake = {
    overlays.default = _final: prev:
      with inputs.nixpkgs-stable.legacyPackages.${prev.system}; {
        inherit libsemanage bottles gnome-extension-manager;
        # python312Packages.patool = python312Packages.patool;
      };
    libraries = libx;
    nixosModules = import ../nixos; # upstream into nixpkgs
    homeManagerModules = import ../home-manager; # upstream into hm
  };

}
