{ pkgs, ... }:
{
  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      name = "jj-diffconflicts";
      src = pkgs.fetchFromGitHub {
        owner = "rafikdraoui";
        repo = "jj-diffconflicts";
        rev = "6d9eedadf1fab87bccb0a4a7ceda829da8023efb";
        hash = "sha256-hvMXpslucywVYA9Sdxx6IcXQXYcYNWK8s9jr+KtStdI=";
      };
    })
  ];
}
