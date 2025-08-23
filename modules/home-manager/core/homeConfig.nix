{ lib, pkgs, config, inputs, username, ... }: {
  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    packages = with pkgs; [
      baobab
      comma
      nurl

      (writeScriptBin "config" # bash
        "cd ${builtins.readFile inputs.root.outPath} && nvim")

    ];

    sessionPath = [ "$HOME/.local/bin" ];
    sessionVariables = { FLAKE = "/home/${username}/.config/nixos"; };

    activation.clean-nixDirectories =
      lib.hm.dag.entryAfter [ "writeBoundary" ] # bash
      ''
        rm -rf ${config.home.homeDirectory}/.nix-defexpr
        rm -rf ${config.home.homeDirectory}/.nix-profile
      '';

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "25.05";
  };
}
