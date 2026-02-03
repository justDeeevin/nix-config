{
  pkgs,
  lib,
  inputs,
  nixvim,
  ...
}:
with pkgs;
[
  pear-desktop
  wl-clipboard
  vlc
  ffmpeg-full
  kdePackages.kalk
  magic-wormhole
  inputs.zen-browser.packages.x86_64-linux.default
  obsidian
  chromium
  nh
  telegram-desktop
  typst
  timg
  r2modman
  (lib.hiPrio uutils-coreutils-noprefix)
  tldr
  bluetui
  nixvim
  nautilus
  osu-lazer-bin
  slack
  lazyjj
  usbutils
  (ouch.override { enableUnfree = true; })
  wiremix
  (unityhub.override {
    extraLibs = fhsPkgs: with fhsPkgs; [ sqlite ];
  })
  gpclient
  eclipses.eclipse-java
  vscode
  nurl
  vscode
  sl
  tsukimi
  equibop
  zoom-us
]
