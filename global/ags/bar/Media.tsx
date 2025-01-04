import { Gtk } from "astal/gtk3";
import { bind } from "astal";
import Mpris from "gi://AstalMpris";

export default () => {
  const mpris = Mpris.get_default();

  return (
    <box className="media">
      {bind(mpris, "players").as((ps) =>
        ps[0] ? (
          <box>
            <box
              className="cover"
              valign={Gtk.Align.CENTER}
              css={bind(ps[0], "coverArt").as(
                (cover) => `background-image: url('${cover}');`,
              )}
            />{" "}
            <label
              label={bind(ps[0], "title").as(
                (title) => `${title} - ${ps[0].artist}`,
              )}
            />
          </box>
        ) : (
          "Nothing Playing"
        ),
      )}
    </box>
  );
};
