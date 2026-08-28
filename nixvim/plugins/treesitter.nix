{ config, ... }:
{
  plugins.treesitter = {
    enable = true;
    highlight.enable = true;
    indent.enable = true;
    grammarPackages = with config.plugins.treesitter.package.builtGrammars; [
      asm
      bash
      bibtex
      c
      cpp
      css
      diff
      dockerfile
      dot
      dart
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
      wgsl
      xml
      yaml
    ];

    languageRegister.wgsl = [ "wesl" ];
  };
}
