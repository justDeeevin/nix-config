{
  pkgs,
  lib,
  inputs,
  nixvim,
  ...
}:
with pkgs;
[
  (lib.hiPrio uutils-coreutils-noprefix)
  (ouch.override { enableUnfree = true; })
  bluetui
  chromium
  eclipses.eclipse-java
  ffmpeg-full
  gpclient
  inputs.zen-browser.packages.x86_64-linux.default
  kdePackages.kalk
  lazyjj
  magic-wormhole
  nautilus
  nh
  nixvim
  nurl
  obsidian
  osu-lazer-bin
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
  vlc
  vscode
  vscode
  wiremix
  wl-clipboard
  wtype
  zoom-us
]
