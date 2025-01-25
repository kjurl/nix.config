# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{ lib, ... }:

with lib.hm.gvariant;

{
  dconf.settings = {
    "com/github/stunkymonkey/nautilus-open-any-terminal" = {
      terminal = "kitty";
    };

    "com/github/tenderowl/frog" = {
      active-language = "eng";
      installation-id = "KZ4q-tBNmDy4AZILagTTF";
      window-height = -1;
      window-width = -1;
    };

    "com/mattjakeman/ExtensionManager" = {
      last-used-version = "0.5.1";
    };

    "com/saivert/pwvucontrol" = {
      enable-overamplification = false;
      is-maximized = false;
      window-height = 1037;
      window-width = 954;
    };

    "com/usebottles/bottles" = {
      show-sandbox-warning = false;
      startup-view = "page_list";
      temp = true;
      window-height = 1028;
      window-width = 1908;
    };

  };
}
