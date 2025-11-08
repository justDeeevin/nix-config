{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    ntfs3g
    gzdoom
    prismlauncher
    gimp
  ];

  programs.niri.settings = {
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

  programs.nushell.shellAliases.warp = "warp-cli";
}
