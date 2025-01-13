import { bind, Variable } from "astal";
import { App, Astal, Gtk } from "astal/gtk3";
import Mpris from "gi://AstalMpris";

const { START, CENTER, END, FILL } = Gtk.Align;

export default (index: Variable<number>) => {
  const mpris = Mpris.get_default();
  const player = Variable.derive(
    [bind(mpris, "players"), index()],
    (ps, i) => ps[i],
  );

  const inner = player().as((p) => (
    <box
      vertical
      css={bind(p, "coverArt").as((c) => `background-image: url('${c}')`)}
    >
      <box halign={FILL}>
        <button
          hexpand
          halign={START}
          onClicked={() => {
            if (mpris.players[index.get() - 1]) index.set(index.get() - 1);
          }}
          cursor="pointer"
          css="margin: 0 8px"
        >
          {"<"}
        </button>
        <label
          css="margin-bottom: 8px"
          label={bind(p, "identity").as((id) => {
            if (p.bus_name === "org.mpris.MediaPlayer2.playerctld") {
              return `Active Player (${id})`;
            } else return id;
          })}
        />
        <button
          hexpand
          halign={END}
          onClicked={() => {
            if (mpris.players[index.get() + 1]) index.set(index.get() + 1);
          }}
          cursor="pointer"
          css="margin: 0 8px"
        >
          {">"}
        </button>
      </box>
      <label css="font-weight: bold" halign={CENTER} label={bind(p, "title")} />
      <label
        halign={CENTER}
        label={bind(p, "album").as(
          (album) => `${p.artist}${album ? ` - ${album}` : ""}`,
        )}
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
  ));

  return (
    <window
      className="media"
      name="media"
      application={App}
      visible={false}
      layer={Astal.Layer.TOP}
      anchor={Astal.WindowAnchor.NONE}
    >
      {inner}
    </window>
  );
};
