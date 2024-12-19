{ lib, pkgs, config, inputs, ... }:
let kys = lib.utils.findKys ./. ++ [ "anyrun" ];
in {
  imports = [ inputs.anyrun.homeManagerModules.default ];
  options = lib.utils.setOptions kys {
    enable = lib.mkEnableOption "anyrun";
    style = lib.mkOption {
      description = "style of anyrun taken from fufexan's config";
      type = lib.types.enum [ "dark" "light" ];
      default = "light";
    };
  };
  config = let cfg = lib.utils.getConfig config kys;
  in lib.mkIf cfg.enable {

    desktop.hyprland.settings = {
      # layerrule = [ "noanim, anyrun" ];
      bindr = let
        pkill = lib.getExe' pkgs.procps "pkill";
        anyrun = lib.getExe pkgs.anyrun;
      in [ "SUPER, SPACE, exec, ${pkill} anyrun || ${anyrun}" ];
    };

    programs.anyrun = {
      enable = true;
      config = {
        plugins = with inputs.anyrun.packages.${pkgs.system}; [
          applications
          shell
          websearch
        ];
        # x.fraction = 0.5;
        y.fraction = 0.3;
        width.fraction = 0.25;
        # height.absolute = 0;
        hideIcons = false;
        ignoreExclusiveZones = false;
        layer = "overlay";
        hidePluginInfo = true;
        closeOnClick = true;
        showResultsImmediately = false;
        maxEntries = 3;
      };

      extraConfigFiles = {
        "applications.ron".text = # ron
          ''
            Config(
              desktop_actions: true,
              max_entries: 5,
              terminal: Some("kitty")
            )
          '';
        "shell.ron".text = # ron
          ''Config(prefix: ">")'';
        "websearch.ron".text = # ron
          ''
            Config(prefix: "?", engines: [
              Custom(
                name: "Brave", 
                url: "search.brave.com/search?q={}&source=desktop"
              ), 
              DuckDuckGo
            ])
          '';
      };
      extraCss = let
        isLight = cfg.style == "light";
        # css
      in ''
        * {
          all: unset;
          font-size: 1.2rem;
          ${if isLight then "color: black;" else ""}
        }

        #window,
        #match,
        #entry,
        #plugin,
        #main {
          background: transparent;
        }

        #match.activatable {
          border-radius: 8px;
          margin: 4px 0;
          padding: 4px;
          /* transition: 100ms ease-out; */
        }
        #match.activatable:first-child {
          margin-top: 12px;
        }
        #match.activatable:last-child {
          margin-bottom: 0;
        }

        #match:hover {
          background: rgba(255, 255, 255, 0.05);
        }
        #match:selected {
          background: rgba(255, 255, 255, 0.1);
        }

        #entry {
          background: rgba(255, 255, 255, 0.05);
          border: 1px solid rgba(255, 255, 255, 0.1);
          border-radius: 8px;
          padding: 4px 8px;
        }

        box#main {
          background: rgba(${
            if isLight then "200, 200, 200" else "0, 0, 0"
          }, 0.5);
          box-shadow:
            inset 0 0 0 1px rgba(255, 255, 255, 0.1),
            0 30px 30px 15px rgba(0, 0, 0, 0.5);
          border-radius: 20px;
          padding: 12px;
        }
      '';
    };

    nix.settings = {
      substituters = [ "https://anyrun.cachix.org" ];
      trusted-public-keys =
        [ "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s=" ];
    };
  };
}
