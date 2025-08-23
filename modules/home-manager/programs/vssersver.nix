{ lib, pkgs, inputs, ... }: {
  imports = [ inputs.vscode-server.homeModules.default ];

  services.vscode-server = {
    enable = true;
    extraRuntimeDependencies = with pkgs; [ nixfmt-classic nil ];
  };
  home.packages = with pkgs; [ nixfmt-classic nil ];

}
