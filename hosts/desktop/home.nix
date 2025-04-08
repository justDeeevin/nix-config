{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [ ntfs3g ];

  wayland.windowManager.hyprland.settings = {
    monitor = [
      "HDMI-A-1, highres@highrr, 0x0, 1, transform, 3"
      "DP-1, highres@highrr, 1080x240, 1"
    ];
    workspace = [
      "1, monitor:HDMI-A-1"
      "2, monitor:HDMI-A-1"
      "3, monitor:HDMI-A-1"
      "4, monitor:DP-1"
      "5, monitor:DP-1"
      "6, monitor:DP-1"
      "7, monitor:DP-1"
      "8, monitor:DP-1"
      "9, monitor:DP-1"
      "10, monitor:DP-1"
    ];
  };

  programs.syspower.settings.monitor = 1;

  programs.vscode.profiles.default = {
    # enable = true;
    extensions =
      with pkgs.vscode-extensions;
      [
        rust-lang.rust-analyzer
        tamasfe.even-better-toml
        ms-vsliveshare.vsliveshare
        fill-labs.dependi
        vadimcn.vscode-lldb
        usernamehw.errorlens
        aaron-bond.better-comments
        irongeek.vscode-env
        supermaven.supermaven
      ]
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "rust-syntax";
          publisher = "dustypomerleau";
          version = "0.6.1";
          sha256 = "sha256-o9iXPhwkimxoJc1dLdaJ8nByLIaJSpGX/nKELC26jGU=";
        }
        {
          name = "oxocarbon";
          publisher = "ibmlover";
          version = "1.0.0";
          sha256 = "sha256-jlRKheDMLCIWMhiORUiM494BbSPV7qkJwhUz6eqk02I=";
        }
      ];
    userSettings = {
      "rust-analyzer.check.command" = "clippy";
      "rust-analyzer.check.noDefaultFeatures" = null;
      "workbench.colorTheme" = lib.mkForce "oxocarbon";
    };
  };
  sops.secrets.OPENAI_API_KEY.sopsFile = ./secrets.yaml;
}
