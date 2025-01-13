import Network from "gi://AstalNetwork";
import { bind } from "astal";
import { App } from "astal/gtk3";

export default () => {
  const network = Network.get_default();
  const wifi = bind(network, "wifi");

  return (
    <button
      className="wifi"
      cursor="pointer"
      visible={wifi.as((w?) => w?.state === Network.DeviceState.ACTIVATED)}
      onClicked={() => App.toggle_window("wifi")}
      tooltipText={bind(network.wifi.active_access_point, "ssid").as(String)}
    >
      {wifi.as(
        (wifi) =>
          wifi && (
            <icon
              tooltipText={bind(wifi, "ssid").as(String)}
              icon={bind(wifi, "iconName")}
            />
          ),
      )}
    </button>
  );
};
