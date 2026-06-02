{
  inputs,
  pkgs,
  myLib,
  ...
}:
let
  system24-oxocarbon = pkgs.fetchFromGitHub {
    owner = "justDeeevin";
    repo = "system24-oxocarbon";
    rev = "main";
    hash = "sha256-chDAyTsLJKv+kXGv2hs506xTSuUFvsgG6TzEOY1mTck=";
  };
in
{
  imports = [ inputs.nixcord.homeModules.default ];

  programs.nixcord = {
    enable = true;

    equibop.enable = true;
    config = {
      plugins = myLib.mkEnableList [
        {
          name = "autoZipper";
          extensions = "";
        }
        "betterSettings"
        "betterUploadButton"
        "bypassPinPrompt"
        "callTimer"
        "consoleJanitor"
        "crashHandler"
        "customSounds"
        "disableCallIdle"
        "experiments"
        "favoriteGifSearch"
        "fixCodeblockGap"
        "forceOwnerCrown"
        "imageZoom"
        "memberCount"
        "mentionAvatars"
        "messageLatency"
        "messageLinkEmbeds"
        "messageLoggerEnhanced"
        "moyai"
        "noDevtoolsWarning"
        "noF1"
        "permissionsViewer"
        "platformIndicators"
        "roleColorEverywhere"
        "secretRingToneEnabler"
        "shikiCodeblocks"
        "showBadgesInChat"
        "showHiddenChannels"
        "silentMessageToggle"
        "typingIndicator"
        {
          name = "typingTweaks";
          amITyping = true;
        }
        "unindent"
        "userMessagesPronouns"
        "userVoiceShow"
        "voiceChatDoubleClick"
        "voiceMessages"
        "volumeBooster"
      ];

      frameless = true;
      useQuickCss = true;
      disableMinSize = true;
    };

    quickCss =
      builtins.replaceStrings
        [ ''--font: "DM Mono"'' ''--code-font: "DM Mono"'' ]
        [ ''--font: "Monaspace Neon"'' ''--code-font: "Monaspace Krypton"'' ]
        (builtins.readFile "${system24-oxocarbon}/system24-oxocarbon.theme.css");

  };
}
