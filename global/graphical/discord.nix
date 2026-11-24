{
  inputs,
  myLib,
  ...
}:
{
  imports = [ inputs.nixcord.homeModules.default ];

  programs.nixcord = {
    enable = true;

    equibop.enable = true;
    discord.enable = false;
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
      enabledThemeLinks = [
        "https://raw.githubusercontent.com/justDeeevin/system24-oxocarbon/refs/heads/main/system24-oxocarbon.theme.css"
      ];
      frameless = true;
      useQuickCss = true;
      plugins = myLib.mkEnableList [
        "addAttachments"
        "betterSettings"
        "betterUploadButton"
        "fixCodeblockGap"
        "forceOwnerCrown"
        "imageZoom"
        "memberCount"
        "mentionAvatars"
        "messageLatency"
        "messageLinkEmbeds"
        "noF1"
        "noUnblockToJump"
        "roleColorEverywhere"
        "secretRingToneEnabler"
        "unindent"
        "userMessagesPronouns"
        "userVoiceShow"
        "voiceChatDoubleClick"
        "volumeBooster"

        # equicord-only
        "alwaysTrust"
        {
          name = "autoZipper";
          extensions = "";
        }
        "bypassPinPrompt"
        "callTimer"
        "disableCallIdle"
        # TODO: tune?
        "equibopStreamFixes"
        "experiments"
        "messageLoggerEnhanced"
        "moyai"
        "platformIndicators"
        "shikiCodeblocks"
        "showAllMessageButtons"
        "showBadgesInChat"
        "typingIndicator"
        {
          name = "typingTweaks";
          # TODO:
          # alternativeFormatting = false;
          amITyping = true;
        }
        "voiceMessages"
      ];
    };
  };
}
