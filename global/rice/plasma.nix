{inputs, ...}: {
  imports = [inputs.plasma-manager.homeManagerModules.plasma-manager];
  programs.plasma = {
    enable = true;
    hotkeys.commands = {
      quickAcess = {
        name = "1Password Quick Access";
        command = "1password --quick-access";
        key = "Ctrl+Shift+Space";
      };
      "1pass" = {
        name = "Launch 1Password";
        command = "1password";
        key = "Ctrl+|";
      };
    };
    panels = [
      {
        alignment = "left";
        location = "bottom";
        screen = "all";
        widgets = [
          {
            kickoff.icon = "nix-snowflake-white";
          }
          {
            iconTasks.launchers = ["applications:systemsettings.desktop" "applications:org.kde.dolphin.desktop" "applications:zen.desktop" "applications:youtube-music.desktop" "applications:org.wezfurlong.wezterm.desktop"];
          }
          {
            systemTray.items = {
              shown = [
                "org.kde.plasma.volume"
                "org.kde.plasma.bluetooth"
                "org.kde.plasma.networkmanagement"
                "org.kde.plasma.battery"
                "org.kde.plasma.clipboard"
              ];
              hidden = ["org.kde.plasma.brightness"];
            };
          }
          "org.kde.plasma.digitalclock"
          "org.kde.plasma.colorpicker"
          "org.kde.plasma.showdesktop"
        ];
      }
    ];

    spectacle.shortcuts.launchWithoutCapturing = "Print";

    input.keyboard = {
      numlockOnStartup = "on";
      layouts = [
        {
          layout = "us";
          variant = "colemak_dh";
        }
      ];
    };
  };
}
