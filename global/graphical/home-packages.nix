{
  pkgs,
  lib,
  inputs,
  nixvim,
  ...
}:
with pkgs;
[
  bluetui
  chromium
  eclipses.eclipse-java
  ffmpeg-full
  gpclient
  kdePackages.kalk
  lazyjj
  mars-mips
  magic-wormhole
  nautilus
  nh
  nixvim
  nurl
  obsidian
  osu-lazer-bin
  (ouch.override { enableUnfree = true; })
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
  vscode
  vscode
  wiremix
  wl-clipboard
  wtype
  inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
  zoom-us
]
