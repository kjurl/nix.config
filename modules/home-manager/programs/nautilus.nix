{ lib, pkgs, ... }: {
  home = let
    nautEnv = pkgs.buildEnv {
      name = "nautilus-env";
      paths = with pkgs; [
        turtle
        sushi
        # nautilus
        (nautilus.overrideAttrs (nsuper: {
          buildInputs = nsuper.buildInputs
            ++ (with gst_all_1; [ gst-plugins-rs ]);
        }))
        nautilus-python
        nautilus-open-any-terminal
      ];
    };
  in {
    packages = with pkgs; [
      nautEnv
      gnome-logs
      gnome-frog
      gnome-text-editor
      evince
    ];
    sessionVariables = {
      NAUTILUS_4_EXTENSION_DIR =
        lib.mkDefault "${nautEnv}/lib/nautilus/extensions-4";
    };
  };
}
