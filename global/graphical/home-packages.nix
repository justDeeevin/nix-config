{
  pkgs,
  lib,
  inputs,
  nixvim,
  isDarwin,
  ...
}:
with pkgs;
[
  pear-desktop
  (if isDarwin then vlc-bin else vlc)
  ffmpeg-full
  jdk
  gradle
  tree-sitter
  magic-wormhole
  inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
  obsidian
  google-chrome
  nh
  telegram-desktop
  typst
  timg
  r2modman
  (lib.hiPrio uutils-coreutils-noprefix)
  tldr
  nixvim
  rip2
  osu-lazer-bin
  slack
  lazyjj
  cargo-seek
  usbutils
  (ouch.override { enableUnfree = true; })
  insomnia
  gpclient
  vscode
  nurl
  python314
  sl
  zoom-us
]
++ lib.optionals (!isDarwin) [
  wl-clipboard
  kodi-wayland
  kdePackages.kalk
  bluetui
  nautilus
  wiremix
  (unityhub.override {
    extraLibs = fhsPkgs: with fhsPkgs; [ sqlite ];
  })
  eclipses.eclipse-java
  tsukimi
  equibop
  gnome-boxes
]
