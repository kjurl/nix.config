{ lib, ... }: {
  imports = lib.x.imports.scanPaths ./.;
  options.main = lib.mkOption { type = lib.types.setType; };
}
