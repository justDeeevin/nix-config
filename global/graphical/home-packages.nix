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
  chromium
  ffmpeg-full
  kdePackages.kalk
  lazyjj
  magic-wormhole
  muse-sounds-manager
  nautilus
  nh
  nixvim
  nurl
  osu-lazer-bin
  (ouch.override { enableUnfree = true; })
  pear-desktop
  r2modman
  sl
  timg
  tldr
  tsukimi
  typst
  usbutils
  (lib.hiPrio uutils-coreutils-noprefix)
  vlc
  wiremix
  wl-clipboard
  wtype
  inputs.zen-browser.packages.${stdenv.hostPlatform.system}.default
  zoom-us
]
