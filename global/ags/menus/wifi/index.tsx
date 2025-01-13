import { App, Astal } from "astal/gtk3";

export default () => {
  return (
    <window
      className="wifi"
      name="wifi"
      application={App}
      layer={Astal.Layer.TOP}
      anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.RIGHT}
      visible={false}
    >
      <box>Wifi</box>
    </window>
  );
};
