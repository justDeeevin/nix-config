import Battery from "gi://AstalBattery";
import { bind } from "astal";

export default () => {
  const battery = Battery.get_default();

  return (
    <box className="battery" visible={bind(battery, "isPresent")}>
      <icon icon={bind(battery, "batteryIconName")} />
      <label
        label={bind(battery, "percentage").as((p) => `${Math.trunc(p * 100)}%`)}
      />
    </box>
  );
};
