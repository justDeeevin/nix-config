{
  programs.waybar = {
    style = builtins.readFile ./waybar.css;
    settings.topBar = {
      modules-left = ["battery"];
      battery.states = {
        warning = 30;
        critical = 15;
      };
    };
  };
}
