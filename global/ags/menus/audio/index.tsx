import { App, Astal } from "astal/gtk3";

export default () => {
  return (
    <window
      className="audio"
      name="audio"
      application={App}
      visible={false}
      layer={Astal.Layer.TOP}
      anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.RIGHT}
    >
      <box>hello</box>
    </window>
  );
};
