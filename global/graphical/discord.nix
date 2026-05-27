{ inputs, pkgs, ... }:
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
    quickCss =
      # css
      ''
        body {
          --font: "Monaspace Neon";
          --code-font: "Monaspace Krypton";
        }
      '';
    config = {
      disableMinSize = true;
      frameless = true;
      plugins =
        let
          mkEnableList =
            plugins:
            builtins.listToAttrs (
              builtins.map (
                plugin:
                if builtins.isAttrs plugin then
                  {
                    inherit (plugin) name;
                    value = builtins.removeAttrs plugin [ "name" ];
                  }
                else
                  {
                    name = plugin;
                    value.enable = true;
                  }
              ) plugins
            );
        in
        mkEnableList [
          {
            name = "autoZipper";
            enable = true;
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
      useQuickCss = true;
      themes.system24-oxocarbon = builtins.readFile "${system24-oxocarbon}/system24-oxocarbon.theme.css";
      enabledThemes = [ "system24-oxocarbon.css" ];
    };
  };
}
