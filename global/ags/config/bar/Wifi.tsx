import Network from "gi://AstalNetwork";
import { bind } from "astal";

export default () => {
  const network = Network.get_default();
  const wifi = bind(network, "wifi");

  return (
    <button className="wifi" cursor="pointer" visible={wifi.as(Boolean)}>
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
