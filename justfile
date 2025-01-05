# just is a command runner, Justfile is very similar to Makefile, but simpler.
# https://cheatography.com/linux-china/cheat-sheets/justfile/
set shell := ["bash", "-c"]

OVERRIDE_FLAKE_ROOT := '--override-input root "file+file://"<(printf %s "$PWD")'
alias b := build

############################################################################
#
#  Common commands(suitable for all machines)
#
############################################################################

# List commands
default:
  @just --list

# Build nix-config for current system
[group('nix')]
build COMMAND='test':
  nh os {{COMMAND}} . -- {{OVERRIDE_FLAKE_ROOT}}

# Show flake
[group('nix')]
show:
  nix flake show . {{OVERRIDE_FLAKE_ROOT}}

# Generate Nix packages from URLs
[group('nix')]
init:
  nix run github:nix-community/nix-init

# Update all the flake inputs
[group('nix')]
up: 
  nix flake update

# Update specific input
# Usage: just upp nixpkgs
[group('nix')]
upp input:
  nix flake update {{input}}

# List all generations of the system profile
[group('nix')]
history:
  nix profile history --profile /nix/var/nix/profiles/system

tree:
  nix run github:utdemir/nix-tree

# Open a nix shell with the flake
[group('nix')]
repl:
  nix repl -f flake:nixpkgs {{OVERRIDE_FLAKE_ROOT}}

# remove all generations older than 7 days
# on darwin, you may need to switch to root user to run this command
[group('nix')]
clean:
  sudo nix profile wipe-history --profile /nix/var/nix/profiles/system  --older-than 7d

# Garbage collect all unused nix store entries
[group('nix')]
gc:
  # garbage collect all unused nix store entries(system-wide)
  sudo nix-collect-garbage --delete-older-than 7d
  # garbage collect all unused nix store entries(for the user - home-manager)
  # https://github.com/NixOS/nix/issues/8508
  nix-collect-garbage --delete-older-than 7d

# Enter a shell session which has all the necessary tools for this flake
[linux]
[group('nix')]
shell:
  nix shell nixpkgs#git nixpkgs#neovim nixpkgs#colmena

# Enter a shell session which has all the necessary tools for this flake
[macos]
[group('nix')]
shell:
  nix shell nixpkgs#git nixpkgs#neovim

[group('nix')]
fmt:
  # format the nix files in this repo
  nix fmt

# Show all the auto gc roots in the nix store
[group('nix')]
gcroot:
  ls -al /nix/var/nix/gcroots/auto/

# Verify all the store entries
# Nix Store can contains corrupted entries if the nix store object has been modified unexpectedly.
# This command will verify all the store entries,
# and we need to fix the corrupted entries manually via `sudo nix store delete <store-path-1> <store-path-2> ...`
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
