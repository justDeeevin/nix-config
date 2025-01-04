import { Astal, Gdk, Gtk } from "astal/gtk3";
import Tray from "./Tray";

export default function Bar(gdkmonitor: Gdk.Monitor) {
  const { TOP, LEFT, RIGHT } = Astal.WindowAnchor;

  return (
    <window
      className="Bar"
      gdkmonitor={gdkmonitor}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      anchor={TOP | LEFT | RIGHT}
    >
      <centerbox>
        <box hexpand halign={Gtk.Align.START}>
          <Tray />
        </box>
        <box />
        <box hexpand halign={Gtk.Align.END}></box>
      </centerbox>
    </window>
  );
}
