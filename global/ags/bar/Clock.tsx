import { GLib, Variable } from "astal";
import { App } from "astal/gtk3";

export default () => {
  const time = Variable("").poll(
    1000,
    () => GLib.DateTime.new_now_local().format("%I:%M %p")!,
  );

  return (
    <button className="time" onClicked={() => App.toggle_window("calendar")}>
      <label label={time()} onDestroy={() => time.drop()} />
    </button>
  );
};
