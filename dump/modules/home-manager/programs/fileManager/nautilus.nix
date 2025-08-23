{ }
# { lib, pkgs, config, ... }:
# lib.z ./. config [ "nautilus" ] { } (cfg:
#   lib.mkIf cfg.enable {
#     home = let
#       nautEnv = pkgs.buildEnv {
#         name = "nautilus-env";
#         paths = with pkgs; [
#           nautilus-python
#           nautilus-open-any-terminal
#           (nautilus.overrideAttrs (nsuper: {
#             buildInputs = nsuper.buildInputs
#               ++ (with gst_all_1; [ gst-plugins-rs gst-plugins-good ]);
#           }))
#           turtle
#           sushi
#         ];
#       };
#     in {
#       packages = with pkgs; [ nautEnv gnome-logs gnome-frog ];
#       sessionVariables = {
#         NAUTILUS_4_EXTENSION_DIR =
#           lib.mkDefault "${nautEnv}/lib/nautilus/extensions-4";
#       };
#     };
#   })
