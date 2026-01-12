{
  plugins.codesnap = {
    enable = true;
    settings = {
      show_line_number = true;
      snapshot_config = {
        window = {
          mac_window_bar = false;
          margin = {
            x = 40;
            y = 25;
          };
        };
        code_config = {
          font_family = "Monaspace Neon";
          breadcrumbs = {
            enable = true;
            font_family = "Monaspace Neon";
          };
        };
        watermark.content = "";
      };
    };
  };
}
