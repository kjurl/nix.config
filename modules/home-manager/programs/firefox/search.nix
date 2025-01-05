{ lib, pkgs, config, ... }:
let kys = lib.utils.findKys ./. ++ [ "search" ];
in {
  options = lib.utils.setOptions kys {
    enable = lib.mkEnableOption "firefox-search-providers";
  };
  config = let cfg = lib.utils.getConfig config kys;
  in lib.mkIf cfg.enable {
    programs.firefox.profiles.default.search = {
      force = true;
      default = "DuckDuckGo";
      engines = {
        "Bing".metaData.hidden = true;
        "Nix Packages" = {
          urls = [{
            template = "https://search.nixos.org/packages";
            params = [
              {
                name = "type";
                value = "packages";
              }
              {
                name = "channel";
                value = "unstable";
              }
              {
                name = "query";
                value = "{searchTerms}";
              }
            ];
          }];
          icon =
            "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "@np" ];
        };
        "Nix Packages Versions" = {
          urls = [{
            template = "https://lazamar.co.uk/nix-versions/";
            params = [
              {
                name = "channel";
                value = "nixpkgs-unstable";
              }
              {
                name = "package";
                value = "{searchTerms}";
              }
            ];
          }];
          icon =
            "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "@npv" ];
        };
        "Home-manager Options" = {
          urls = [{
            template = "https://home-manager-options.extranix.com";
            params = [
              {
                name = "release";
                value = "master";
              }
              {
                name = "query";
                value = "{searchTerms}";
              }
            ];
          }];
          icon =
            "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "@hm" ];
        };
        "NixOS Wiki" = {
          urls = [{
            template = "https://wiki.nixos.org/index.php";
            params = [{
              name = "query";
              value = "{searchTerms}";
            }];
          }];
          icon =
            "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "@nw" ];
        };
      };
    };
  };
}
