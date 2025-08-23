{ lib, config, inputs, ... }:
let cfg = config.modules.shell;
in lib.mkIf true {
  programs.direnv = {
    enable = true;
    silent = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
    config = {
      global = {
        load_dotennv = true;
        strict_env = true;
        warn_timout = "0";
      };
      whitelist.exact =
        [ "~/Documents/website" (builtins.readFile inputs.root.outPath) ];
    };
  };
}
