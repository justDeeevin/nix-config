{ pkgs, ... }:
{
  plugins.treesitter = {
    enable = true;
    settings.highlight.enable = true;
    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      bash
      css
      dockerfile
      dot
      html
      java
      javadoc
      javascript
      json
      lua
      markdown
      nix
      nu
      regex
      rust
      svelte
      toml
      tsx
      typescript
      typst
      xml
    ];
  };
}
