import { Astal, Gdk, Gtk } from "astal/gtk3";
import GLib from "gi://GLib?version=2.0";
import Tray from "./Tray";
import Workspaces from "./Workspaces";
import WindowTitle from "./WindowTitle";
import Clock from "./Clock";
import Media from "./Media";
import Audio from "./Audio";
import Wifi from "./Wifi";
import { readFile, Variable } from "astal";

type Modules = {
  wifi: boolean;
  battery: boolean;
};

export default function Bar(
  gdkmonitor: Gdk.Monitor,
  player_i: Variable<number>,
) {
  const { TOP, LEFT, RIGHT } = Astal.WindowAnchor;
  const { wifi, battery } = JSON.parse(
    readFile(`${GLib.get_home_dir()}/.config/bar-modules.json`),
  ) as Modules;

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
          {wifi && <Wifi />}
        </box>
      </centerbox>
    </window>
  );
}
