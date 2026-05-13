{
  lib,
  appimageTools,
  makeDesktopItem,
  fetchurl,
}:
let
  pname = "grimoire";
  version = "1.7.2";
  src = fetchurl {
    url = "https://github.com/Slush97/grimoire/releases/download/v${version}/Grimoire-${version}.AppImage";
    hash = "sha256-rfo+CzZ35yCAer/2jdB3MqdNjQn1PC0X1zR/OjOoUus=";
  };
  desktopItem = makeDesktopItem {
    name = "grimoire";
    desktopName = "Grimoire";
    comment = "Mod manager for Deadlock";
    exec = "grimoire";
    icon = "grimoire";
    terminal = false;
    keywords = [
      "Deadlock"
      "Mods"
      "Modding"
      "Mod Manager"
      "Game"
      "Valve"
    ];
    startupWMClass = "grimoire";
  };
  contents = appimageTools.extract { inherit pname version src; };
in
(appimageTools.wrapType2 {
  inherit pname version src;

  executableName = "grimoire";

  extraInstallCommands = ''
    mkdir $out/share
    ln -s ${desktopItem}/share/applications $out/share/applications

    cp -r ${contents}/usr/share/icons $out/share
  '';

  meta = with lib; {
    description = "Mod manager for Deadlock";
    homepage = "https://github.com/Slush97/grimoire";
    license = licenses.mit;
    mainProgram = "grimoire";
    maintainers = with maintainers; [ justdeeevin ];
    platforms = platforms.linux;
  };
}).overrideAttrs
  (old: {
    __structuredAttrs = true;
    strictDeps = true;
  })
