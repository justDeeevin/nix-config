import Hyprland from "gi://AstalHyprland";
import { bind } from "astal";
import { Gdk } from "astal/gtk3";
import { getMonitorId } from "../lib";

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
          .reverse()
          .map((ws) => (
            <button
              className={bind(hyprland, "focusedWorkspace").as((fw) =>
                ws === fw ? "focused" : "",
              )}
              onClicked={() => ws.focus()}
            >
              <label
                label={bind(ws, "clients").as(
                  (clients) =>
                    ws.id.toString() +
                    "|" +
                    clients.map((client) => getIcon(client)).join(" "),
                )}
              />
            </button>
          )),
      )}
    </box>
  );
};

function getIcon(client: Hyprland.Client) {
  switch (client.initial_class) {
    case "zen-beta":
      return "󰈹";
    case "com.mitchellh.ghostty":
      return "";
    case "YouTube Music":
      return "";
    case "vesktop":
      return "";
    case "steam":
      return "";
    default:
      return "";
  }
}
