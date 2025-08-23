{ lib, config, options, getSystem, moduleWithSystem, withSystem, ... }: {
  imports = lib.x.imports.scanPaths ./.;
}
