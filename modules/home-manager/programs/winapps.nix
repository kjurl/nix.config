{ lib, pkgs, inputs, config, ... }: {
  nix.settings = {
    substituters = [ "https://winapps.cachix.org/" ];
    trusted-public-keys =
      [ "winapps.cachix.org-1:HI82jWrXZsQRar/PChgIx1unmuEsiQMQq+zt05CD36g=" ];
  };

  home.packages = with inputs.winapps.packages.${pkgs.system}; [
    winapps
    winapps-launcher # optional
  ];

  xdg.configFile."winapps".source = let
    mkMutableSymlink = path:
      config.lib.file.mkOutOfStoreSymlink (builtins.readFile inputs.root.outPath
        + lib.strings.removePrefix (toString inputs.self) (toString path));
  in mkMutableSymlink ../../../config/winapps;

}
