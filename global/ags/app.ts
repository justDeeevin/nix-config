import { App } from "astal/gtk3";
import { Variable } from "astal";
import style from "./style.scss";
import Mpris from "gi://AstalMpris";
import NotificationPopups from "./notifications/popups";
import Bar from "./bar";
import Calendar from "./menus/calendar";
import Media from "./menus/media";
import Audio from "./menus/audio";
// import Wifi from "./menus/wifi";

App.start({
  css: style,
  main() {
    NotificationPopups();
    App.get_monitors().map((m) => Bar(m));
    Calendar();
    Media();
    Audio();
    // Wifi();
  },
});
