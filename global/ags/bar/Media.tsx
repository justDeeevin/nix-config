import { Gtk } from "astal/gtk3";
import { bind, Variable } from "astal";
import Mpris from "gi://AstalMpris";

export default () => {
  const mpris = Mpris.get_default();

  return (
    <box className="media">
      {bind(mpris, "players").as((ps) => {
        const label = Variable.derive(
          [
            bind(ps[0], "title"),
            bind(ps[0], "artist"),
            bind(ps[0], "playback_status"),
          ],
          (
            title: string,
            artist: string,
            playback_status: Mpris.PlaybackStatus,
          ) => {
            const { PLAYING, PAUSED, STOPPED } = Mpris.PlaybackStatus;
            let status: string;
            switch (playback_status) {
              case PLAYING:
                status = "";
                break;
              case PAUSED:
                status = "";
                break;
              case STOPPED:
                status = "";
                break;
            }

            return title
              ? `${status} ${title}${artist ? ` - ${artist}` : ""}`
              : "Nothing Playing";
          },
        );

        return ps[0] ? (
          <box>
            {ps[0] && ps[0].title && (
              <box
                className="cover"
                valign={Gtk.Align.CENTER}
                css={bind(ps[0], "coverArt").as(
                  (cover) => `background-image: url('${cover}');`,
                )}
              />
            )}
            <label label={label()} truncate />
          </box>
        ) : (
          "Nothing Playing"
        );
      })}
    </box>
  );
};
