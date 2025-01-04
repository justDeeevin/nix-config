import Hyprland from "gi://AstalHyprland";
import { bind } from "astal";

export default () => {
  const hyprland = Hyprland.get_default();
  const focused = bind(hyprland, "focusedClient");

  return (
    <box className="window-title" visible={focused.as(Boolean)}>
      {focused.as(
        (client) =>
          client && <label label={bind(client, "title").as(String)} />,
      )}
    </box>
  );
};
