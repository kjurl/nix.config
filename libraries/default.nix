lib: {
  x = {
    browser = import ./browser.nix lib;
    imports = import ./imports.nix lib;
    options = import ./options.nix lib;
    u = import ./utils.nix lib;
  };

  mkUnlessWsl = cfg: body: lib.mkIf (!cfg.modules.system.wsl.enable) body;
  mkIff = conds: body: lib.mkIf (lib.all (c: c) conds) body;
}
