{
  programs.nixvim.plugins.codesnap = {
    enable = true;
    settings = {
      watermark = "";
      has_breadcrumbs = true;
      has_line_number = true;
      bg_theme = "sea";
      bg_x_padding = 40;
      bg_y_padding = 25;
    };
  };
}
