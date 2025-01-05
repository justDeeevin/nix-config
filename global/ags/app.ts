import { App } from "astal/gtk3";
import { Variable } from "astal";
import style from "./style.scss";
import NotificationPopups from "./notifications/popups";
import Bar from "./bar/index";
import Calendar from "./menus/calendar/index";
import Media from "./menus/media/index";

App.start({
  css: style,
  main() {
    const player_i = Variable(0);

    NotificationPopups();
    App.get_monitors().map((m) => Bar(m, player_i));
    Calendar();
    Media(player_i);
  },
});
