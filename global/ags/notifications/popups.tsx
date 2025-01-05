import { Astal, Gtk } from "astal/gtk3";
import Notifd from "gi://AstalNotifd";
import Notification from "./box";
import { type Subscribable } from "astal/binding";
import { Variable, bind } from "astal";
import Hyprland from "gi://AstalHyprland";

class NotifiationMap implements Subscribable {
  private map: Map<number, Gtk.Widget> = new Map();
  private var: Variable<Array<Gtk.Widget>> = Variable([]);

  private notifiy() {
    this.var.set([...this.map.values()].reverse());
  }

  private set(key: number, value: Gtk.Widget) {
    this.map.get(key)?.destroy();
    this.map.set(key, value);
    this.notifiy();
  }

  private delete(key: number) {
    this.map.get(key)?.destroy();
    this.map.delete(key);
    this.notifiy();
  }

  constructor() {
    const notifd = Notifd.get_default();

    notifd.connect("notified", (_, id) => {
      this.set(id, Notification(notifd.get_notification(id)!));
    });

    notifd.connect("resolved", (_, id) => {
      this.delete(id);
    });
  }

  get() {
    return this.var.get();
  }

  subscribe(callback: (list: Array<Gtk.Widget>) => void) {
    return this.var.subscribe(callback);
  }
}

export default function NotificationPopups() {
  const { TOP, RIGHT } = Astal.WindowAnchor;
  const notifs = new NotifiationMap();
  const hyprland = Hyprland.get_default();
  const monitor = bind(hyprland, "focusedMonitor");

  return (
    <window
      className="NotificationPopups"
      monitor={monitor.as((monitor) => monitor.id)}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      anchor={TOP | RIGHT}
    >
      <box vertical>{bind(notifs)}</box>
    </window>
  );
}
