import { GLib } from "astal";
import { Gtk, Astal } from "astal/gtk3";
import Notifd from "gi://AstalNotifd";

const isIcon = (icon: string) => !!Astal.Icon.lookup_icon(icon);

const fileExists = (path: string) => GLib.file_test(path, GLib.FileTest.EXISTS);

const time = (time: number, format = "%H:%M") =>
  GLib.DateTime.new_from_unix_local(time).format(format)!;

const urgency = (n: Notifd.Notification) => {
  const { LOW, NORMAL, CRITICAL } = Notifd.Urgency;
  switch (n.urgency) {
    case LOW:
      return "low";
    case CRITICAL:
      return "critical";
    case NORMAL:
    default:
      return "normal";
  }
};

export default function Notification(notif: Notifd.Notification) {
  const { START, CENTER, END } = Gtk.Align;

  return (
    <eventbox className={`Notification ${urgency(notif)}`}>
      <box vertical>
        <box className="header">
          {(notif.appIcon || notif.desktopEntry) && (
            <icon
              className="app-icon"
              visible={Boolean(notif.appIcon || notif.desktopEntry)}
              icon={notif.appIcon || notif.desktopEntry}
            />
          )}
          <label
            className="app-name"
            halign={START}
            truncate
            label={notif.appName || "Unknown"}
          />
          <label
            className="time"
            hexpand
            halign={END}
            label={time(notif.time)}
          />
          <button onClick={() => notif.dismiss()} cursor="pointer">
            <icon icon="window-close-symbolic" />
          </button>
        </box>
        <Gtk.Separator visible />
        <box className="content">
          {notif.image && fileExists(notif.image) && (
            <box
              valign={START}
              className="image"
              css={`
                background-image: url("${notif.image}");
              `}
            />
          )}
          {notif.image && isIcon(notif.image) && (
            <box expand={false} valign={START} className="icon-image">
              <icon icon={notif.image} expand halign={CENTER} valign={CENTER} />
            </box>
          )}
          <box vertical>
            <label
              className="summary"
              halign={START}
              xalign={0}
              label={notif.summary}
              truncate
            />
            {notif.body && (
              <label
                className="body"
                wrap
                useMarkup
                halign={START}
                xalign={0}
                justifyFill
                label={notif.body}
              />
            )}
          </box>
        </box>
        {notif.get_actions().length > 0 && (
          <box className="actions">
            {notif.get_actions().map(({ label, id }) => (
              <button hexpand onClick={() => notif.invoke(id)} cursor="pointer">
                <label label={label} halign={CENTER} hexpand />
              </button>
            ))}
          </box>
        )}
      </box>
    </eventbox>
  );
}
