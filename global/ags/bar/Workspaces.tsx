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
              className={bind(hyprland, "focusedWorkspace").as((fw) =>
                ws === fw ? "focused" : "",
              )}
              onClicked={() => ws.focus()}
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

function getIcon(client: Hyprland.Client) {
  const apps = new Apps.Apps();

  const results = apps.fuzzy_query(client.initial_title);
  return results[0]?.icon_name ?? "Window";
}
