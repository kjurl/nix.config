# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{ lib, ... }:

with lib.hm.gvariant;

{
  dconf.settings = {
    "org/gnome/mutter" = {
      dynamic-workspaces = false;
      edge-tiling = true;
      num-workspaces = 4;
      overlay-key = "Super_L";
      workspaces-only-on-primary = true;
    };

  };
}
