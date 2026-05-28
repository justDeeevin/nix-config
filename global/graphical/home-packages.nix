{
  inputs,
  pkgs,
  lib,
  nixvim,
  ...
}:
with pkgs;
[
  bluetui
  (callPackage ./BrickVault { })
  chromium
  eclipses.eclipse-java
  ffmpeg-full
  gpclient
  kdePackages.kalk
  lazyjj
  magic-wormhole
  nautilus
  nh
  nixvim
  nurl
  obsidian
  osu-lazer-bin
  (ouch.override { enableUnfree = true; })
  pan
  pear-desktop
  r2modman
  sl
  slack
  telegram-desktop
  timg
  tldr
  tsukimi
  typst
  (unityhub.override {
    extraLibs = fhsPkgs: with fhsPkgs; [ sqlite ];
  })
  usbutils
  (lib.hiPrio uutils-coreutils-noprefix)
  vlc
  wiremix
  wl-clipboard
  wtype
  inputs.zen-browser.packages.${stdenv.hostPlatform.system}.default
  zoom-us
]
