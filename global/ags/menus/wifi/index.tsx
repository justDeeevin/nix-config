import { App, Astal } from "astal/gtk3";
import Network from "gi://AstalNetwork";
import { bind, execAsync, Variable } from "astal";

export default () => {
  const network = Network.get_default();

  const pending = Variable<String | undefined>(undefined);

  const aps = bind(network.wifi, "access_points").as((aps) => {
    const map = new Map<string, Network.AccessPoint>();
    aps.forEach((item) => {
      if (item.ssid !== null && !map.has(item.ssid)) map.set(item.ssid, item);
    });

    let active: Network.AccessPoint | undefined;
    for (const [ssid, ap] of map.entries()) {
      if (ssid === network.wifi.active_access_point.ssid) {
        active = ap;
        map.delete(ssid);
      }
    }

    return {
      active,
      available: Array.from(map.values()),
    };
  });

  return (
    <window
      className="wifi"
      name="wifi"
      application={App}
      layer={Astal.Layer.TOP}
      anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.RIGHT}
      visible={false}
    >
      <box vertical>
        <label css="font-weight: bold" label="Connected" />
        {aps.as((aps) => aps.active?.ssid ?? "None")}
        <label css="font-weight: bold" label="Available" />
        {Variable.derive([aps, pending()], (aps, pend) =>
          aps.available.map((ap) => (
            <box>
              <button
                cursor="pointer"
                onClicked={() => {
                  pending.set(ap.ssid);
                  execAsync(`nmcli device wifi connect ${ap.bssid}`).then(() =>
                    pending.set(undefined),
                  );
                }}
                label={ap.ssid}
              />
              {pend === ap.ssid && "..."}
            </box>
          )),
        )()}
      </box>
    </window>
  );
};
