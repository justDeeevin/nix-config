{ pkgs, ... }:
{
  plugins.treesitter = {
    enable = true;
    highlight.enable = true;
    indent.enable = true;
    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      bash
      c
      cpp
      css
      diff
      dockerfile
      dot
      html
      java
      javadoc
      javascript
      json
      just
      latex
      lua
      make
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
