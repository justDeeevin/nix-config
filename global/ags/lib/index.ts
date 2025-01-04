import { Gdk } from "astal/gtk3";

export function getMonitorId(monitor: Gdk.Monitor) {
  const display = Gdk.Display.get_default()!;
  const screen = display.get_default_screen();
  for (let i = 0; i < screen.get_n_monitors(); i++) {
    if (monitor === display.get_monitor(i)) {
      return i;
    }
  }
}
