<h1 align="center">
  <img src="./assets/nixos-logo.png  " width="100px" /> 
  <br>
  Nix config
  <br>
  <img 
    src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/palette/macchiato.png"
    width="600px"
  /><br>
  <div align="center">
    <div align="center">
      <!-- <p></p> -->
      <div align="center">
        <a href="https://github.com/kjurl/nix.config/stargazers"><img src="https://img.shields.io/github/stars/kjurl/nix.config?color=F5BDE6&labelColor=303446&style=for-the-badge&logo=starship&logoColor=F5BDE6"></a>
        <a href="https://github.com/kjurl/nix.config/"><img src="https://img.shields.io/github/repo-size/kjurl/nix.config?color=C6A0F6&labelColor=303446&style=for-the-badge&logo=github&logoColor=C6A0F6"></a>
        <a = href="https://nixos.org"><img src="https://img.shields.io/badge/NixOS-stable-blue.svg?style=for-the-badge&labelColor=303446&logo=NixOS&logoColor=white&color=91D7E3"></a>
        <a href="https://github.com/kjurl/nix.config/blob/main/LICENSE"><img src="https://img.shields.io/static/v1.svg?style=for-the-badge&label=License&message=MIT&colorA=313244&colorB=F5A97F&logo=unlicense&logoColor=F5A97F&"/></a>
      </div>
      <br>
   </div>
</h1>

<!-- ## Gallery 
<p align="center">
  <img src="./.github/assets/screenshots/sakura-desktop.png" /> <br>
  Screenshots last updated <b>2024-09-04</b>
</p> -->

## References
 - **Config Structure** - 
  (heavily inspired by [snowfall](https://github.com/snowfallorg/lib)) 
  [mobsenpai](https://github.com/mobsenpai/hana), 
  [jakehamilton](https://github.com/jakehamilton/config), 
  [IogaMaster](https://github.com/IogaMaster/dotfiles) 
  and [snowfall-starter](https://github.com/IogaMaster/snowfall-starter) 
  { [chezmoi](https://www.chezmoi.io/) inspiration from [rayandrew](https://github.com/rayandrew/dotfiles) (dropped from this config) }
 - **Nix Configs** - by
  [n30ney](https://github.com/n3oney/nixus), 
  [number5](https://github.com/number5/nix-home), 
  [ryan4yin](https://github.com/ryan4yin/nix-config), 
  [end-4](https://github.com/end-4/dots-hyprland), 
  [Icy-Thought](https://github.com/Icy-Thought/snowflake), 
  [sukhmancs](https://github.com/sukhmancs/nixos-configs/tree/main)
 - **Hyprland Dots** - by
  [linuxmobile](https://github.com/linuxmobile/hyprland-dots)
 - Other Mentions - 
  [chezmoi and nix configs by budimanjojo](https://github.com/budimanjojo/nix-config), 
  [battery and TLP support](https://github.com/TechsupportOnHold/Batterylife/blob/main/laptop.nix)
 - [swaync config](https://github.com/arfan-on-clouds/hyprclouds/blob/main/README.md)
 - [haumea-examples](https://primamateria.github.io/blog/haumea-cheatsheet/)
 - **Haumea Blobs** - 
  [home-manager integration](https://github.com/cody-quinn/dotfiles/blob/23e7e0ca8093516d0f2d4ac49d887196d6c54ec4/flake.nix#L68), 
  [in hivebus](https://github.com/GTrunSec/hivebus/blob/59ed0576ad12ea5c81000b7241ee121f09ca4498/units/std/cells/nixos/nixosModules.nix#L7), 
  [from tao3k](https://github.com/tao3k/flops/blob/8dec3f00bf5e01049597f46641c645eeae28796f/examples/haumea.nix#L2)
- ***Apprunners*** - [Loungy](https://github.com/MatthiasGrandl/loungy), [Waybar-Raycast](https://gist.github.com/veloii/033300e532c43e3cdbd25a145bae2c66)
 - Others - 
  [TahlonBrahic](https://github.com/TahlonBrahic/nix-config), 
  [ocfox](https://github.com/ocfox/den), 
  [CirnOS by end-4](https://github.com/end-4/CirnOS/tree/main), 
  [anyrun config by linuxmobile](https://github.com/linuxmobile/kaku/blob/13eb9e8a19823cb2fa2aed29f7b1f49bea51c4a2/home/software/anyrun/default.nix#L7)
  [containers-list for firefox](https://github.com/shvchk/containerise-lists)
---

## Personal

<details>
<summary>Code Snippets</summary>

### flake.nix
```nix
module = inputs.haumea.lib.load {
 src = ./modules/nixos;
 inputs = {
   inherit inputs;
   rself = self;
 };
 loader = inputs.haumea.lib.loaders.default lib;
 # transformer = inputs.haumea.lib.transformers.liftDefault;
};
```
</details>
<details>
<summary>My Todo List</summary>

### Functionality
- [ ] `nix flake check`
    - [x] [repo](https://github.com/Gerschtli/nix-formatter-pack) is very old
    - [x] added [derivation](https://msfjarvis.dev/posts/writing-your-own-nix-flake-checks)
    - [x] write bash scripts for [statix](https://github.com/nerdypepper/statix) and [deadnix](https://github.com/astro/deadnix)
- [ ] Screensharing
    - Discourse - [Hyprland](https://discourse.nixos.org/t/hyprland-screen-sharing/43658), [Sway and Hyprland](https://discourse.nixos.org/t/sway-and-firefox-screensharing/31576)
    - Hyprland wiki - [Screen-sharing](https://wiki.hyprland.org/hyprland-wiki/pages/Useful-Utilities/Screen-Sharing/), [Hyprland Desktop Portal](https://wiki.hyprland.org/hyprland-wiki/pages/Useful-Utilities/Hyprland-desktop-portal/)
    - [Github Issue](https://github.com/hyprwm/Hyprland/issues/6396)
    - [test page](https://mozilla.github.io/webrtc-landing/gum_test.html)
- [ ] [Impermanence](https://github.com/nix-community/impermanence)
  - [Erase your darlings](https://grahamc.com/blog/erase-your-darlings)
  - [Encrypted BTRFS with Opt-In State on NixOS](https://mt-caret.github.io/blog/posts/2020-06-29-optin-state.html)
  - [NixOS: tmpfs as root](https://elis.nu/blog/2020/05/nixos-tmpfs-as-root/) and [tmpfs as home](https://elis.nu/blog/2020/06/nixos-tmpfs-as-home/)
- [ ] Winapps
- [ ] Secrets
  - [ ] [Comparision](https://nixos.wiki/wiki/Comparison_of_secret_managing_schemes)
  - [ ] [Initial Guide](https://0xda.de/blog/2024/07/framework-and-nixos-sops-nix-secrets-management/)
  - [ ] Integrate BitWarden for secret keys, so I have to remember only one master password
- [ ] [haumea.loaders.path](https://nix-community.github.io/haumea/api/loaders.html#loaderspath) structured repo 
    - [x] lib function for repeated options and cfg at top of files
- [ ] [Rclone](https://wiki.nixos.org/wiki/Rclone) with config from [RoundSync](https://github.com/newhinton/Round-Sync)
- [ ] integrate [nix4nvchad](https://github.com/nix-community/nix4nvchad?tab=readme-ov-file)
- **NIXPKGS** - 
  [pandoc](https://pandoc.org/installing.html), 
  [autodesk](https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/wiki/Documentation#--arch-linux-based), 
- **Additions** - 
  [wireguard](https://nixos.wiki/wiki/WireGuard), 
  [openVPN](https://nixos.wiki/wiki/OpenVPN), 
  [winapps](https://github.com/winapps-org/winapps)
- make a choice between nil vs nixd

> #### Completed
> 

### Theming
- [ ] better plymouth theme - also smooth boot- no blinking 
- [ ] remove hyprland terminal output on signing-in 
- [ ] Regreet - 
  [greetd wiki](https://nixos.wiki/wiki/Greetd), 
  [regreet setup](https://discourse.nixos.org/t/setting-up-regreet/53623), 
  [regreet vs gtkgreet](https://discourse.nixos.org/t/gtkgreet-or-regreeter-with-greetd-with-hyprland/29202)

</details>
## Guides
- [packagin python apps](https://nixos.wiki/wiki/Packaging/Python)
- [lib functions](https://ryantm.github.io/nixpkgs/)
