{
  plugins.minuet = {
    enable = true;
    settings = {
      cmp.enable_auto_complete = false;
      blink.enable_auto_complete = false;
      virtualtext = {
        auto_trigger_ft = [ "*" ];
        auto_trigger_ignore_ft = [ "oil" ];
        keymap = {
          accept_line = "<Tab>";
          accept = "<S-Tab>";
          accept_n_lines = "<C-Tab>";
        };
        show_on_completion_ = true;
      };

      # TODO: both
      debounce = 100;
      throttle = 400;

      provider = "openai_fim_compatible";
      n_completions = 1;
      # TODO:
      context_window = 512;
      provider_options.openai_fim_compatible = {
        api_key = "TERM";
        name = "Llama.cpp";
        end_point = "http://localhost:8012/v1/completions";
        model = "PLACEHOLDER";
        # TODO:
        optional.max_tokens = 56;
        template = {
          prompt.__raw = ''
            function(ctx_before, ctx_after, _)
              return '<|fim_prefix|>'
                .. ctx_before
                .. '<|fim_suffix|>'
                .. ctx_after
                .. '<|fim_middle|>'
            end
          '';
          suffix = false;
        };
      };
    };
  };
}
