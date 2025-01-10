import { App, Gtk } from "astal/gtk3";
import { bind, Variable } from "astal";
import Mpris from "gi://AstalMpris";

export default ({ index }: { index: Variable<number> }) => {
  const mpris = Mpris.get_default();
  const player = Variable.derive(
    [bind(mpris, "players"), index()],
    (ps, i) => ps[i],
  );
  const inner = player().as((p) => {
    const label = Variable.derive(
      [bind(p, "title"), bind(p, "artist")],
      (title, artist) => {
        return title
          ? `${title}${artist ? ` - ${artist}` : ""}`
          : "Nothing Playing";
      },
    );

    return p ? (
      <box>
        {p && p.title && (
          <button onClicked={() => p.play_pause()} cursor="pointer">
            <label
              label={bind(p, "playback_status").as((s) => {
                const { PLAYING, PAUSED, STOPPED } = Mpris.PlaybackStatus;
                switch (s) {
                  case PLAYING:
                    return "󰐊";
                  case PAUSED:
                    return "󰏤";
                  case STOPPED:
                    return "󰓛";
                }
              })}
            />
          </button>
        )}
        <button onClicked={() => App.toggle_window("media")} cursor="pointer">
          <box>
            {p && p.title && (
              <box
                className="cover"
                valign={Gtk.Align.CENTER}
                css={bind(p, "coverArt").as(
                  (cover) => `background-image: url('${cover}');`,
                )}
              />
            )}
            <label label={label()} truncate />
          </box>
        </button>
      </box>
    ) : (
      "Nothing Playing"
    );
  });

  return <box className="media">{inner}</box>;
};
