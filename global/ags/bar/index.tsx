import { Astal, Gdk, Gtk } from "astal/gtk3";
import { Variable } from "astal";

import Tray from "./Tray";
import Workspaces from "./Workspaces";
import WindowTitle from "./WindowTitle";
import Clock from "./Clock";
import Media from "./Media";
import Audio from "./Audio";
// import Wifi from "./Wifi";
import Battery from "./Battery";

export default function Bar(
  gdkmonitor: Gdk.Monitor,
  player_i: Variable<number>,
) {
  const { TOP, LEFT, RIGHT } = Astal.WindowAnchor;

  return (
    <window
      className="bar"
      gdkmonitor={gdkmonitor}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      anchor={TOP | LEFT | RIGHT}
      layer={Astal.Layer.TOP}
    >
      <centerbox>
        <box hexpand halign={Gtk.Align.START}>
          <Tray />
          <Workspaces monitor={gdkmonitor} />
          <WindowTitle />
        </box>
        <box>
          <Clock />
        </box>
        <box hexpand halign={Gtk.Align.END}>
          <Media index={player_i} />
          <Audio />
          {/* <Wifi /> */}
          <Battery />
        </box>
      </centerbox>
    </window>
  );
}
