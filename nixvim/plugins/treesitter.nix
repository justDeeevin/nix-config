{ pkgs, ... }:
{
  plugins.treesitter = {
    enable = true;
    highlight.enable = true;
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
      latex
      markdown
      markdown_inline
      nix
      nu
      regex
      rust
      svelte
      toml
      tsx
      typescript
      typst
      vim
      xml
    ];
  };
}
