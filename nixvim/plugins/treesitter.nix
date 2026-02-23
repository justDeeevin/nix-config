{ pkgs, ... }:
{
  plugins.treesitter = {
    enable = true;
    highlight.enable = true;
    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      bash
      css
      c
      cpp
      dockerfile
      dot
      html
      java
      javadoc
      javascript
      json
      just
      lua
      latex
      markdown
      markdown_inline
      nix
      nu
      python
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
