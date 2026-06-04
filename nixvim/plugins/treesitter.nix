{ config, ... }:
{
  plugins.treesitter = {
    enable = true;
    highlight.enable = true;
    indent.enable = true;
    grammarPackages = with config.plugins.treesitter.package.builtGrammars; [
      asm
      bash
      c
      cpp
      css
      diff
      dockerfile
      dot
      haskell
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
      ocaml
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
      yaml
    ];
  };
}
