import { App, Gtk } from "astal/gtk3";
import { bind, Variable } from "astal";
import Mpris from "gi://AstalMpris";

export default ({ index }: { index: Variable<number> }) => {
  const mpris = Mpris.get_default();

  const inner = Variable.derive(
    [bind(mpris, "players"), index],
    (players, i) => {
      const p = players[i];

      const label = Variable.derive(
        [bind(p, "title"), bind(p, "artist")],
        (title, artist) => `${title}${artist ? ` - ${artist}` : ""}`,
      );

      // When there is no active player, Mpris doesn't actually set the player to `null`. It just sets a handful of properties to `null`. Ultimately, if every single one of the below properties is null, even if there's an active player, we don't have anything to display and thus want to just say "nothing playing".
      const properties_to_check: Array<keyof Mpris.Player> = [
        "cover_art",
        "title",
        "artist",
      ];

      const visible = Variable.derive(
        properties_to_check.map((key) => bind(p, key)),
        (...props) => props.every((v) => v !== null && v !== ""),
      );

      return (
        <box className="media" visible={visible()}>
          <box>
            <button onClicked={() => p.play_pause()} cursor="pointer">
              <label
                label={bind(p, "playback_status").as((s) => {
                  const { PLAYING, PAUSED, STOPPED } = Mpris.PlaybackStatus;
                  switch (s) {
                    case PLAYING:
                      return "󰏤";
                    case PAUSED:
                      return "󰐊";
                    case STOPPED:
                      return "󰓛";
                  }
                })}
              />
            </button>
            <button
              onClicked={() => App.toggle_window("media")}
              cursor="pointer"
            >
              <box>
                <box
                  className="cover"
                  valign={Gtk.Align.CENTER}
                  css={bind(p, "coverArt").as(
                    (cover) => `background-image: url('${cover}');`,
                  )}
                />
                <label label={label()} truncate />
              </box>
            </button>
          </box>
        </box>
      );
    },
  );

  return <box>{inner()}</box>;
};
