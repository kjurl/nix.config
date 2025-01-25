{ lib, ... }:
let inherit (lib) utils mkAliasOptionModule;
in {
  # https://github.com/sreedevk/dot
  imports = utils.scanPaths ./. ++ [
    (mkAliasOptionModule [ "desktop" "hyprland" "keybinds" ] [
      "wayland"
      "windowManager"
      "hyprland"
      "settings"
      "bind"
    ])

    (mkAliasOptionModule [ "desktop" "hyprland" "settings" ] [
      "wayland"
      "windowManager"
      "hyprland"
      "settings"
    ])
  ];
}
