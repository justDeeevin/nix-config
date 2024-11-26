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
    input.keyboard.numlockOnStartup = "on";
    workspace = {
      # wallpaper = pkgs.fetchurl {
      #   url = "https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/ec13709a-43f2-4b25-9089-5967ff8b5874/db86uf5-d0d11a70-321e-4fdb-9d87-83a7c86764e4.jpg/v1/fill/w_894,h_894,q_70,strp/scp_3001_by_sunnyclockwork_db86uf5-pre.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9MTAwMCIsInBhdGgiOiJcL2ZcL2VjMTM3MDlhLTQzZjItNGIyNS05MDg5LTU5NjdmZjhiNTg3NFwvZGI4NnVmNS1kMGQxMWE3MC0zMjFlLTRmZGItOWQ4Ny04M2E3Yzg2NzY0ZTQuanBnIiwid2lkdGgiOiI8PTEwMDAifV1dLCJhdWQiOlsidXJuOnNlcnZpY2U6aW1hZ2Uub3BlcmF0aW9ucyJdfQ.hA-Gx7Dxt612kUwgOLtCKt8TiLWzgGWiF1G9XEAJ9Y4";
      #   hash = "";
      # };
      wallpaperFillMode = "pad";
      # wallpaperPlainColor = "1,1,1,256";
      lookAndFeel = "Carl";
      cursor = {
        size = 32;
        theme = "Posy's Cursor";
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
  };
}
