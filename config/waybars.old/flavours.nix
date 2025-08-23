{ pkgs }:
with pkgs; {
  "win10" = "${
      fetchFromGitHub {
        owner = "TheFrankyDoll";
        repo = "win10-style-waybar";
        rev = "71c4f4f99e7ccd807bc0933defc514323e570b79";
        hash = "sha256-TEDCY5CAcsOt3cXY5M/y7AeXJTCdbVnE9rfPMpyPY/s=";
      }
    }/waybar";
  "fav" = "${
      fetchFromGitHub {
        owner = "EviLuci";
        repo = "dotfiles";
        rev = "main";
        hash = "sha256-KytmXu8buD2n3SOoX3ArT3cRI0dEktkLfIbDR10JERU=";
      }
    }.config/waybar";
  "folder" = "${
      fetchFromGitHub {
        owner = "Bwc9876";
        repo = "nix-conf";
        rev = "8ccb830e4b8364c16714964d688edb7f3897567e";
        hash = "sha256-rxrLvcrX668f72Rw6TLQzh9izGeoiLWydPWyMeb6B9g=";
      }
    }/res/waybar";
  "super" = "${
      fetchFromGitHub {
        owner = "Anik200";
        repo = "dotfiles";
        rev = "super-waybar";
        hash = "sha256-vQoqJL4F04bV5bJrRc8amGdIfAMXmExrxDd0+bwBN90=";
      }
    }/.config/waybar";
  "ego" = "${
      fetchFromGitHub {
        owner = "Egosummiki";
        repo = "dotfiles";
        rev = "ea0f2e3a031f24176906e91616783a4c050f0f05";
        hash = "sha256-mt/5RZa0wIZ41fdYyuuD2z3poEJyGtp9PKEAQlHD2FQ=";
      }
    }/waybar";
  "minimal" = "${
      fetchFromGitHub {
        owner = "ashish-kus";
        repo = "waybar-minimal";
        rev = "800e62cc790794bbacf50357492910ba165bdfe4";
        hash = "sha256-Hk/NFfCg3Jbf94u+5An206nLvBwaFtJPc4wVWX8+ZbQ=";
      }
    }/src";
  "default" = ../../../config/waybar;
}

