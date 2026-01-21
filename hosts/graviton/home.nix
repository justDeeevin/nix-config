{
  pkgs,
  lib,
  ...
}:
{
  home.packages = with pkgs; [
    ntfs3g
    gzdoom
    prismlauncher
    gimp
    reaper
  ];

  programs.niri.settings = {
    outputs.DP-1 = {
      backdrop-color = "010101";
      variable-refresh-rate = true;
      mode = {
        height = 1440;
        width = 2560;
        refresh = 239.999;
      };
      position = {
        x = 1080;
        y = (1920 - 1440) / 2;
      };
    };
    outputs.HDMI-A-1 = {
      backdrop-color = "010101";
      position = {
        x = 0;
        y = 0;
      };
      transform.rotation = 270;
    };
    spawn-at-startup = [
      {
        argv = [
          (lib.getExe pkgs.openrgb)
          "-p"
          (builtins.toString ./icy.orp)
        ];
      }
      {
        argv = [
          "slack"
          "--startup"
        ];
      }
    ];
    window-rules = [
      {
        matches = [ { app-id = "equibop"; } ];
        open-maximized = true;
      }
    ];
  };

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
