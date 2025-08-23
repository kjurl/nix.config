{ lib, ... }: {
  perSystem = { inputs', config, pkgs, system, ... }: {
    devenv.shells.default = {
      devenv.root =
        let devenvRootFileContent = builtins.readFile inputs'.root.outPath;
        in pkgs.lib.mkIf (devenvRootFileContent != "") devenvRootFileContent;

      # https://github.com/cachix/devenv/issues/760
      containers = lib.mkForce { };

      difftastic.enable = true;
      packages = with pkgs; [ just lazygit deadnix nixfmt-classic ];
      languages.nix = {
        enable = true;
        lsp.package = pkgs.nixd;
      };
      pre-commit.hooks.shellcheck.enable = true;
      # See full reference at https://devenv.sh/reference/options/
    };
  };
}
