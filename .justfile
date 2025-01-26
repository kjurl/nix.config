# just is a command runner, Justfile is very similar to Makefile, but simpler.
# https://cheatography.com/linux-china/cheat-sheets/justfile/
set shell := ["bash", "-c"]

OVERRIDE_FLAKE_ROOT := '--override-input root "file+file://"<(printf %s "$PWD")'

############################################################################
#
#  Common commands(suitable for all machines)
#
############################################################################

# List commands
default:
  @just --list

_pre-build:

_post-build:

# Alias to `build test`
[group('nix-build')]
@b:
  just build test

# Build nix-config for current system
[group('nix-build')]
build COMMAND *FLAGS: _pre-build && _post-build
  nh os {{COMMAND}} . -- {{FLAGS}} {{OVERRIDE_FLAKE_ROOT}} 

# Alternative to update then switch
[group('nix-build')]
update: 
  just build switch --update

# Usage: just upp nixpkgs
[group('nix-build')]
update-package input:
  nix flake update {{input}}

# Generate Nix packages from URLs
[group('nix-tools')]
init:
  nix run github:nix-community/nix-init

# Browse dependency graphs of Nix-drvs. 
[group('nix-tools')]
tree:
  nix run github:utdemir/nix-tree

# Generate to dconf.gen
[group('nix-tools')]
dconf:
  dconf dump /system/ | nix run nixpkgs#dconf2nix -- --root system > modules/home-manager/desktop/dconf.gen/system.nix
  dconf dump /org/gnome/shell/ | nix run nixpkgs#dconf2nix -- --root /org/gnome/shell > modules/home-manager/desktop/dconf.gen/shell.nix
  dconf dump /org/gnome/desktop/ | nix run nixpkgs#dconf2nix -- --root /org/gnome/desktop > modules/home-manager/desktop/dconf.gen/desktop.nix
  dconf dump /org/gnome/settings-daemon/ | nix run nixpkgs#dconf2nix -- --root /org/gnome/settings-daemon > modules/home-manager/desktop/dconf.gen/settings.nix
  dconf dump /org/gnome/mutter/ | nix run nixpkgs#dconf2nix -- --root /org/gnome/mutter > modules/home-manager/desktop/dconf.gen/mutter.nix
  dconf dump /com/ | nix run nixpkgs#dconf2nix -- --root /com > modules/home-manager/desktop/dconf.gen/com.nix
  dconf dump /org/virt-manager/ | nix run nixpkgs#dconf2nix -- --root /org/virt-manager > modules/home-manager/desktop/dconf.gen/virt.nix

# Show flake outputs
[group('nix-info')]
show:
  nix flake show . {{OVERRIDE_FLAKE_ROOT}}

# List all generations (system profile)
[group('nix-info')]
history:
  nix profile history --profile /nix/var/nix/profiles/system

# Show all the auto gc roots (nix store)
[group('nix-info')]
gcroot:
  ls -al /nix/var/nix/gcroots/auto/

# Open a nix shell with the flake
[group('nix-dev')]
repl:
  nix repl -f flake:nixpkgs {{OVERRIDE_FLAKE_ROOT}}

# on darwin, you may need to switch to root user to run this command
# Remove all generations older than 7 days
[group('nix-clean')]
clean:
  sudo nix profile wipe-history \
    --profile /nix/var/nix/profiles/system  \
    --older-than 7d
  nix-env --delete-generations old
  nix-store --gc
  for link in /nix/var/nix/gcroots/auto/*
  do rm $(readlink "$link") done
  nix-collect-garbage -d

# Garbage collect all unused nix store entries
[group('nix-clean')]
gc:
  # garbage collect all unused nix store entries(system-wide)
  sudo nix-collect-garbage --delete-older-than 7d
  # garbage collect all unused nix store entries(for the user - home-manager)
  # https://github.com/NixOS/nix/issues/8508
  nix-collect-garbage --delete-older-than 7d


# Nix Store can contains corrupted entries 
# if the nix store object has been modified unexpectedly.
# This command will verify all the store entries,
# and we need to fix the corrupted entries manually via
# `sudo nix store delete <store-path-1> <store-path-2> ...`
# Verify all the store entries
[group('nix')]
verify-store:
  nix store verify --all

# Repair Nix Store Objects
[group('nix')]
repair-store *paths:
  nix store repair {{paths}}

# =================================================
#
# Other useful commands
#
# =================================================

[group('common')]
path:
   $env.PATH | split row ":"

# Remove all reflog entries and prune unreachable objects
[group('git')]
ggc:
  git reflog expire --expire-unreachable=now --all
  git gc --prune=now

# Amend the last commit without changing the commit message
[group('git')]
game:
  git commit --amend -a --no-edit
