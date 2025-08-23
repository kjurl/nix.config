{ lib, config, ... }:
let cfg = config.modules.services.kanata-keybd;
in lib.mkIf cfg.enable {
  services.kanata = {
    enable = true;
    keyboards = {
      homerow = {
        devices = [ "/dev/input/event0" ];
        extraDefCfg = "process-unmapped-keys yes";
        config = ''
          (defsrc
           caps a s d f j k l ;
          )
          (defvar
           tap-time 200
           hold-time 250
          )
          (defalias
           caps (tap-hold 100 100 esc lctl)
           a (tap-hold $tap-time $hold-time a lmet)
           s (tap-hold $tap-time $hold-time s lalt)
           d (tap-hold $tap-time $hold-time d lsft)
           f (tap-hold $tap-time $hold-time f lctl)
           j (tap-hold $tap-time $hold-time j rctl)
           k (tap-hold $tap-time $hold-time k rsft)
           l (tap-hold $tap-time $hold-time l ralt)
           ; (tap-hold $tap-time $hold-time ; rmet)
          )

          (deflayer base
           @caps @a  @s  @d  @f  @j  @k  @l  @;
          )
        '';
      };
    };
  };
}

