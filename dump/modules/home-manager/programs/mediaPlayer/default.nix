{ }
# { lib, pkgs, config, ... }:
# lib.z ./. config [ ] { } (cfg:
#   lib.mkIf cfg.enable {
#     home.packages = with pkgs; [ playerctl ];
#     programs = {
#       imv.enable = true;
#       mpv = {
#         enable = true;
#         defaultprofiles = [ "gpu-hq" ];
#         scripts = [ pkgs.mpvscripts.mpris ];
#       };
#     };

#     xdg.mimeapps.defaultapplications = {
#       "audio/*" = "mpv.desktop";
#       "image/*" = "imv.desktop";
#       "video/*" = "mpv.desktop";
#     };
#   })
# # TODO: separate into modules
