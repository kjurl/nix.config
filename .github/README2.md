<h1 align="center">
   <img src="./.github/assets/nixos-logo.png  " width="100px" /> 
   <br>
      kjurel/nixos.config
   <br>
      <img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/palette/macchiato.png" width="600px" /> <br>
   <div align="center">

   <div align="center">
      <p></p>
      <div align="center">
         <a href="https://github.com/kjurel/nixos.config/stargazers">
            <img src="https://img.shields.io/github/stars/kjurel/nixos.config?color=F5BDE6&labelColor=303446&style=for-the-badge&logo=starship&logoColor=F5BDE6">
         </a>
         <a href="https://github.com/kjurel/nixos.config/">
            <img src="https://img.shields.io/github/repo-size/kjurel/nixos.config?color=C6A0F6&labelColor=303446&style=for-the-badge&logo=github&logoColor=C6A0F6">
         </a>
         <a = href="https://nixos.org">
            <img src="https://img.shields.io/badge/NixOS-unstable-blue.svg?style=for-the-badge&labelColor=303446&logo=NixOS&logoColor=white&color=91D7E3">
         </a>
         <a href="https://github.com/kjurel/nixos.config/blob/main/LICENSE">
            <img src="https://img.shields.io/static/v1.svg?style=for-the-badge&label=License&message=MIT&colorA=313244&colorB=F5A97F&logo=unlicense&logoColor=F5A97F&"/>
         </a>
      </div>
      <br>
   </div>
</h1>
https://github.com/linuxmobile
https://github.com/linuxmobile/hyprland-dots?tab=readme-ov-file
https://github.com/end-4/CirnOS/tree/main
https://github.com/linuxmobile/kaku/blob/13eb9e8a19823cb2fa2aed29f7b1f49bea51c4a2/home/software/anyrun/default.nix#L7
add home-manager options to nixd
https://github.com/shvchk/containerise-lists
<!--### Gallery-->
<!---->
<!--<p align="center">-->
<!--   <img src="./.github/assets/screenshots/sakura-desktop.png" /> <br>-->
<!--   Screenshots last updated <b>2024-09-04</b>-->
<!--</p>-->
<!---->
https://github.com/Icy-Thought/snowflake
### TODO
- [x] `nix flake check` 
    - [x] [repo](https://github.com/Gerschtli/nix-formatter-pack) is very old
    - [x] added [derivation](https://msfjarvis.dev/posts/writing-your-own-nix-flake-checks)
    - [x] write bash scripts for [statix](https://github.com/nerdypepper/statix) and [deadnix](https://github.com/astro/deadnix)
- [ ] Screensharing
    - Discourse - [Hyprland](https://discourse.nixos.org/t/hyprland-screen-sharing/43658), [Sway and Hyprland](https://discourse.nixos.org/t/sway-and-firefox-screensharing/31576)
    - Hyprland wiki - [Screen-sharing](https://wiki.hyprland.org/hyprland-wiki/pages/Useful-Utilities/Screen-Sharing/), [Hyprland Desktop Portal](https://wiki.hyprland.org/hyprland-wiki/pages/Useful-Utilities/Hyprland-desktop-portal/)
    - [Github Issue](https://github.com/hyprwm/Hyprland/issues/6396)
    - [test page](https://mozilla.github.io/webrtc-landing/gum_test.html)
- [ ] Winapps setup
- [ ] [more advanced options for secret management](https://nixos.wiki/wiki/Comparison_of_secret_managing_schemes)
- [ ] impermanence setup
> You might have noticed that there's impurity in your NixOS system, in the form of configuration files and other cruft your system generates when running. What if you change them in a whim to get something working and forget about it? Boom, your system is not fully reproductible anymore.
> You can instead fully delete your `/` and `/home` on every boot! Nix is okay with a empty root on boot (all you need is `/boot` and `/nix`), and will happily reapply your configurations.
> There's two main approaches to this: mount a `tmpfs` (RAM disk) to `/`, or (using a filesystem such as btrfs or zfs) mount a blank snapshot and reset it on boot.
> For stuff that can't be managed through nix (such as games downloaded from steam, or logs), use [impermanence](https://github.com/nix-community/impermanence) for mounting stuff you to keep to a separate partition/volume (such as `/nix/persist` or `/persist`). This makes everything vanish by default, and you can keep track of what you specifically asked to be kept.
> Here's some awesome blog posts about it:
> - [Erase your darlings](https://grahamc.com/blog/erase-your-darlings)
> - [Encrypted BTRFS with Opt-In State on NixOS](https://mt-caret.github.io/blog/posts/2020-06-29-optin-state.html)
> - [NixOS: tmpfs as root](https://elis.nu/blog/2020/05/nixos-tmpfs-as-root/) and [tmpfs as home](https://elis.nu/blog/2020/06/nixos-tmpfs-as-home/)
- [ ] [haumea.loaders.path](https://nix-community.github.io/haumea/api/loaders.html#loaderspath) structured repo 
    - [x] lib function for repeated options and cfg at top of files
- [ ] [Rclone](https://wiki.nixos.org/wiki/Rclone) with config from [RoundSync](https://github.com/newhinton/Round-Sync)
- [ ] [Libvirt](https://wiki.nixos.org/wiki/Libvirt) support for a [tinywin11 image](https://github.com/ntdevlabs/tiny11builder)
- [ ] fonts - `JetBrainsMonoNerdFont`, `vscode-codicons`
- [ ] [wezterm bash integration](https://github.com/wez/wezterm/blob/main/assets/shell-integration/wezterm.sh)
- [ ] integrate [nix4nvchad](https://github.com/nix-community/nix4nvchad?tab=readme-ov-file)
- [ ] get a better plymouth theme


### ☕  Acknowledgements
 - **Config Structure** - (heavily inspired by [snowfall](https://github.com/snowfallorg/lib)) [mobsenpai](https://github.com/mobsenpai/hana), [jakehamilton](https://github.com/jakehamilton/config), [IogaMaster](https://github.com/IogaMaster/dotfiles) and [snowfall-starter](https://github.com/IogaMaster/snowfall-starter) { [chezoi](https://www.chezmoi.io/) inspiration from [rayandrew](https://github.com/rayandrew/dotfiles) } 
 - **[AGS](https://aylur.github.io/ags-docs/) configs**, courtesy of [aylur/dotfiles](https://github.com/aylur/dotfiles)
 - chezmoi and nix configs - [budimanjojo](https://github.com/budimanjojo/nix-config)
 - [TechsupportOnHold/Batterylife](https://github.com/TechsupportOnHold/Batterylife/blob/main/laptop.nix) - battery and TLP support
 -  Swaync configs - [arfan-on-clouds](https://github.com/arfan-on-clouds/hyprclouds/blob/main/README.md)

 - [haumea-examples](https://primamateria.github.io/blog/haumea-cheatsheet/)

 ---
![GitHub Repo stars](https://img.shields.io/github/stars/TahlonBrahic/nix-config?style=social&logo=github&label=TahlonBrahic%2Fnix-config&link=https%3A%2F%2Fgithub.com%2FTahlonBrahic%2Fnix-config)
- https://github.com/ocfox/den
- https://github.com/cody-quinn/dotfiles/blob/23e7e0ca8093516d0f2d4ac49d887196d6c54ec4/flake.nix#L68
- https://github.com/GTrunSec/hivebus/blob/59ed0576ad12ea5c81000b7241ee121f09ca4498/units/std/cells/nixos/nixosModules.nix#L7
- https://github.com/tao3k/flops/blob/8dec3f00bf5e01049597f46641c645eeae28796f/examples/haumea.nix#L2
- https://github.com/n3oney/nixus
- https://github.com/number5/nix-home
- Apprunners - [Loungy](https://github.com/MatthiasGrandl/loungy), [Waybar-Raycast](https://gist.github.com/veloii/033300e532c43e3cdbd25a145bae2c66)
- [ryan4yin](https://github.com/ryan4yin/nix-config), [end-4](https://github.com/end-4/dots-hyprland)

---
## Windoes
- Dotfiles: [end-4/dots-hyprland > archive](https://github.com/end-4/dots-hyprland/tree/archive)
- GTK Theme: [Fluent-gtk-theme](https://github.com/vinceliuice/Fluent-gtk-theme)
- Icon Pack: [Win11-icon-theme](https://github.com/yeyushengfan258/Win11-icon-theme)
- Tray: [waybar](https://github.com/Alexays/Waybar/) and [Eww](https://github.com/elkowar/eww/tree/master)
- Random anime girl: [waifu.pics](https://waifu.pics/docs)
- Wallpaper: [by wirestock on Freepik](https://www.freepik.com/free-photo/cool-geometric-triangular-figure-neon-laser-light-great-backgrounds-wallpapers_9851510.htm)
- add pandoc

nil vs nixd
