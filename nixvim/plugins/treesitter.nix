{ config, ... }:
{
  plugins.treesitter = {
    enable = true;
    highlight.enable = true;
    indent.enable = true;
    grammarPackages = with config.plugins.treesitter.package.builtGrammars; [
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
