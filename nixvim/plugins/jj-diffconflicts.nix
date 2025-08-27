{ pkgs, ... }:
{
  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      name = "jj-diffconflicts";
      src = pkgs.fetchFromGitHub {
        owner = "rafikdraoui";
        repo = "jj-diffconflicts";
        rev = "8140e5295ef2008a947f1f374c2d71a5bc7e38a0";
        hash = "sha256-LM2eP29yK+lIlWzJiIKIRcbVjNhyjV2unE4GJDTLKXQ=";
      };
    })
  ];
}
