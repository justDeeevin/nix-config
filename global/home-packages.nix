{
  pkgs,
  lib,
  inputs,
  nixvim,
  ...
}:
with pkgs;
[
  gh
  youtube-music
  wl-clipboard
  just
  vlc
  ffmpeg-full
  kdePackages.kalk
  jdk
  gradle
  # prismlauncher
  wineWowPackages.waylandFull
  unzip
  tree-sitter
  magic-wormhole
  libreoffice
  inputs.zen-browser.packages.x86_64-linux.default
  obsidian
  chromium
  quickemu
  nh
  hyprpolkitagent
  telegram-desktop
  hyprland-qtutils
  cargo-generate
  # godot
  typst
  sops
  timg
  r2modman
  (lib.hiPrio uutils-coreutils-noprefix)
  tldr
  # gimp
  bluetui
  nixvim
  rip2
  equibop
  nautilus
  osu-lazer-bin
]
