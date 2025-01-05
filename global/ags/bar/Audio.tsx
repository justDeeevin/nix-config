import { bind, Variable } from "astal";
import Wp from "gi://AstalWp";

export default () => {
  const wp = Wp.get_default()!;
  const speaker = wp.audio.default_speaker;

  const label = Variable.derive(
    [
      bind(speaker, "volume"),
      bind(speaker, "mute"),
      bind(speaker, "description"),
    ],
    (volume, muted, description) =>
      `${volume * 100}% ${muted ? "" : ""} ${description}`,
  );

  return (
    <box className="audio">
      <label truncate label={label()} />
    </box>
  );
};
