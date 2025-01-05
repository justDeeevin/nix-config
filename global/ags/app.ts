import { App } from "astal/gtk3";
import style from "./style.scss";
import NotificationPopups from "./notifications/popups";
import Bar from "./bar/index";
import Calendar from "./menus/calendar/index";

App.start({
  css: style,
  main() {
    NotificationPopups();
    App.get_monitors().map(Bar);
    Calendar();
  },
});
