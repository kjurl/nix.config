{ lib, pkgs, config, inputs, osConfig, ... }:
let cfg = osConfig.modules.system.desktop;
in {
  imports = [ inputs.stylix.homeManagerModules.stylix ]
    ++ lib.utils.scanPaths ./.;
  options.modules.desktop = let inherit (lib) mkOption types;
  in {
    desktopEnvironment = mkOption {
      description = "the selected desktop environment";
      type = types.nullOr (types.enum [ "gnome" "kde" ]);
      default = null;
    };
    windowManager = mkOption {
      type = types.nullOr (types.enum [ "Hyprland" ]);
      description = "Window manager to use";
      default = null;
    };

    terminal = {
      exePath = mkOption {
        type = types.str;
        default = lib.getExe config.programs.kitty.package;
      };
      class = mkOption {
        type = types.str;
        default = "Kitty";
        description = "Window class of the terminal";
      };
      description = "Information about the default terminal";
    };

    colorscheme = mkOption {
      description = "colorscheme based on base16Scheme";
      default = "caroline";
      type = types.str;
    };
    wallpaper = let
      url =
        "https://raw.githubusercontent.com/zhichaoh/catppuccin-wallpapers/refs/heads/main/os/nix-black-4k.png";
      sha256 = "144mz3nf6mwq7pmbmd3s9xq7rx2sildngpxxj5vhwz76l1w5h5hx";
      file = lib.last (lib.splitString "/" url);
    in {
      default = mkOption {
        type = lib.types.path;
        default = builtins.fetchurl {
          name = "wallpaper-${file}";
          inherit url sha256;
        };
        description = ''
          The default wallpaper to use.
        '';
      };
    };
  };

  config = lib.mkIf cfg.enable {
    stylix = {
      enable = true;
      targets = { waybar.enable = false; };
      # polarity = "dark";
      image = config.modules.desktop.wallpaper.default;
      # image = config.lib.stylix.pixel config.modules.desktop.colorscheme;
      base16Scheme = {
        system = "base16";
        name = "Catppuccin Mocha";
        author = "https://github.com/catppuccin/catppuccin";
        variant = "dark";
        palette = {
          base00 = "#1e1e2e"; # base
          base01 = "#181825"; # mantle
          base02 = "#313244"; # surface0
          base03 = "#45475a"; # surface1
          base04 = "#585b70"; # surface2
          base05 = "#cdd6f4"; # text
          base06 = "#f5e0dc"; # rosewater
          base07 = "#b4befe"; # lavender
          base08 = "#f38ba8"; # red
          base09 = "#fab387"; # peach
          base0A = "#f9e2af"; # yellow
          base0B = "#a6e3a1"; # green
          base0C = "#94e2d5"; # teal
          base0D = "#89b4fa"; # blue
          base0E = "#cba6f7"; # mauve
          base0F = "#f2cdcd"; # flamingo
        };
      };

      # yaml
      # ''
      #   system: "base16"
      #   name: "Catppuccin Mocha"
      #   author: "https://github.com/catppuccin/catppuccin"
      #   variant: "dark"
      #   palette:
      #     base00: "#1e1e2e" # base
      #     base01: "#181825" # mantle
      #     base02: "#313244" # surface0
      #     base03: "#45475a" # surface1
      #     base04: "#585b70" # surface2
      #     base05: "#cdd6f4" # text
      #     base06: "#f5e0dc" # rosewater
      #     base07: "#b4befe" # lavender
      #     base08: "#f38ba8" # red
      #     base09: "#fab387" # peach
      #     base0A: "#f9e2af" # yellow
      #     base0B: "#a6e3a1" # green
      #     base0C: "#94e2d5" # teal
      #     base0D: "#89b4fa" # blue
      #     base0E: "#cba6f7" # mauve
      #     base0F: "#f2cdcd" # flamingo
      # '';
      # "${pkgs.base16-schemes}/share/themes/${config.modules.desktop.colorscheme}.yaml";
      cursor = {
        package = lib.mkDefault pkgs.bibata-cursors; # pkgs.vanilla-dmz
        name = "Bibata-Modern-Ice"; # "Vanilla-DMZ"
        size = lib.mkDefault 24;
      };
      targets = { neovim.enable = false; };
      # cursor.package = ;
    };
  };
}
