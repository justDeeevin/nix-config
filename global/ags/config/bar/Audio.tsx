import { bind } from "astal";
import Wp from "gi://AstalWp";

export default () => {
  const wp = Wp.get_default()!;
  const speaker = wp.audio.default_speaker;

  return (
    <box className="audio">
      <label
        label={bind(speaker, "volume").as((v) => `${Math.trunc(v * 100)}%`)}
      />
      <icon icon={bind(speaker, "volumeIcon")} />
      <label truncate label={bind(speaker, "description")} />
    </box>
  );
};
