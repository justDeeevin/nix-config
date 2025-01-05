import Hyprland from "gi://AstalHyprland";
import { bind } from "astal";
import { Gdk } from "astal/gtk3";
import { getMonitorId } from "../lib";
import Apps from "gi://AstalApps";

export default ({ monitor }: { monitor: Gdk.Monitor }) => {
  const hyprland = Hyprland.get_default();

  return (
    <box className="workspaces">
      {bind(hyprland, "workspaces").as((wss) =>
        wss
          .filter(
            (ws) =>
              !(ws.id >= -99 && ws.id <= -2) &&
              ws.monitor.id === getMonitorId(monitor),
          )
          .sort((a, b) => a.id - b.id)
          .map((ws) => (
            <button
              cursor="pointer"
              className={bind(hyprland, "focusedWorkspace").as((fw) =>
                ws === fw ? "focused" : "",
              )}
              onClick={() => ws.focus()}
            >
              <box>
                {`${ws.id}|`}
                {bind(ws, "clients").as((c) =>
                  c.map((c) => <icon icon={getIcon(c)} />),
                )}
              </box>
            </button>
          )),
      )}
    </box>
  );
};

export function getIcon(client: Hyprland.Client) {
  const apps = new Apps.Apps();

  return (
    iconQuirks(client) ??
    apps.fuzzy_query(client.initial_title)[0]?.icon_name ??
    apps.fuzzy_query(client.title)[0]?.icon_name ??
    apps.fuzzy_query(client.initial_class)[0]?.icon_name ??
    apps.fuzzy_query(client.class)[0]?.icon_name ??
    "Window"
  );
}

function iconQuirks(client: Hyprland.Client) {
  const apps = new Apps.Apps();

  if (client.initial_class === "com.mitchellh.ghostty")
    return apps.exact_query("Ghostty")[0].icon_name;
  else if (client.initial_class === "com.obsproject.Studio")
    return apps.exact_query("OBS Studio")[0].icon_name;
}
