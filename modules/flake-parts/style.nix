{ ... }: {
  perSystem = { pkgs', system, ... }: {
    formatter = pkgs'.nixfmt-classic;
    checks.lint-check = pkgs'.runCommandLocal "lint-check" {
      nativeBuildInputs = with pkgs'; [ statix deadnix ];
      src = ./.;
    } "statix check; deadnix";
  };
}
