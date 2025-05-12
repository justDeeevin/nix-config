import { bind, Variable } from "astal";
import { App, Astal, Gtk } from "astal/gtk3";
import Mpris from "gi://AstalMpris";

const { START, CENTER, END, FILL } = Gtk.Align;

export default () => {
  const mpris = Mpris.get_default();
  const p = mpris.players[0];

  return (
    <window
      className="media"
      name="media"
      application={App}
      visible={false}
      layer={Astal.Layer.TOP}
      anchor={Astal.WindowAnchor.NONE}
    >
      <box
        vertical
        css={bind(p, "coverArt").as((c) => `background-image: url('${c}')`)}
      >
        <label css="margin-bottom: 8px" label={bind(p, "identity")} />
        <label
          css="font-weight: bold"
          halign={CENTER}
          label={bind(p, "title")}
        />
        <label
          halign={CENTER}
          label={Variable.derive(
            [bind(p, "album"), bind(p, "artist")],
            (album, artist) => `${artist}${album ? ` - ${album}` : ""}`,
          )()}
        />
        <box halign={CENTER} css="margin: 8px 0">
          <button cursor="pointer" onClicked={() => p.previous()}>
            󰒮
          </button>
          <button
            cursor="pointer"
            onClicked={() => p.play_pause()}
            css="margin: 0 8px"
          >
            {bind(p, "playback_status").as((status) => {
              const { PLAYING, PAUSED, STOPPED } = Mpris.PlaybackStatus;
              switch (status) {
                case PLAYING:
                  return "󰐊";
                case PAUSED:
                  return "󰏤";
                case STOPPED:
                  return "󰓛";
              }
            })}
          </button>
          <button cursor="pointer" onClicked={() => p.next()}>
            󰒭
          </button>
        </box>
      </box>
    </window>
  );
};
