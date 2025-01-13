import { App, Astal } from "astal/gtk3";
import { bind, Variable } from "astal";
import Wp from "gi://AstalWp";

export default () => {
  const wp = Wp.get_default()!;

  return (
    <window
      className="audio"
      name="audio"
      application={App}
      visible={false}
      layer={Astal.Layer.TOP}
      anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.RIGHT}
    >
      <box vertical>
        <label css="font-weight: bold" label="Speakers" />
        {bind(wp.audio, "speakers").as((l) =>
          l.map((s) => (
            <button onClicked={() => (s.is_default = true)}>
              <label
                label={Variable.derive(
                  [bind(s, "is_default"), bind(s, "description")],
                  (def, desc) => `${def ? "󰄬" : ""} ${desc}`,
                )()}
              />
            </button>
          )),
        )}
        <label css="font-weight: bold" label="Microphones" />
        {bind(wp.audio, "microphones").as((l) =>
          l.map((s) => (
            <button onClicked={() => (s.is_default = true)}>
              <label
                label={Variable.derive(
                  [bind(s, "is_default"), bind(s, "description")],
                  (def, desc) => `${def ? "󰄬" : ""} ${desc}`,
                )()}
              />
            </button>
          )),
        )}
      </box>
    </window>
  );
};
