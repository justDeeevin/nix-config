import { App } from "astal/gtk3";
import { Variable } from "astal";
import style from "./style.scss";
import Mpris from "gi://AstalMpris";
import NotificationPopups from "./notifications/popups";
import Bar from "./bar/index";
import Calendar from "./menus/calendar/index";
import Media from "./menus/media/index";

const player_i = Variable(0);

App.start({
  css: style,
  main() {
    NotificationPopups();
    App.get_monitors().map((m) => Bar(m, player_i));
    Calendar();
    Media(player_i);
  },
  requestHandler(request, respond) {
    if (request.startsWith("media")) {
      const mpris = Mpris.get_default();
      const player = mpris.players[player_i.get()];
      switch (request.split(" ")[1]) {
        case "next":
          player.next();
          break;
        case "previous":
          player.previous();
          break;
        case "play":
          player.play_pause();
          break;
          break;
        default:
          respond(false);
          return;
      }
    } else respond(false);
  },
});
