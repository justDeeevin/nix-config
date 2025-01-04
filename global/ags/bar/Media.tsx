import { Gtk } from "astal/gtk3";
import { bind, Variable } from "astal";
import Mpris from "gi://AstalMpris";

export default () => {
  const mpris = Mpris.get_default();

  return (
    <box className="media">
      {bind(mpris, "players").as((ps) => {
        const label = Variable.derive(
          [bind(ps[0], "title"), bind(ps[0], "artist")],
          (title: string, artist: string) => `${title} - ${artist}`,
        );
        return ps[0] ? (
          <box>
            <box
              className="cover"
              valign={Gtk.Align.CENTER}
              css={bind(ps[0], "coverArt").as(
                (cover) => `background-image: url('${cover}');`,
              )}
            />
            <label label={label()} />
          </box>
        ) : (
          "Nothing Playing"
        );
      })}
    </box>
  );
};
