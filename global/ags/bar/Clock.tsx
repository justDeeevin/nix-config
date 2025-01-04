import { GLib, Variable } from "astal";

export default () => {
  const time = Variable("").poll(
    1000,
    () => GLib.DateTime.new_now_local().format("%I:%M %p")!,
  );

  return (
    <box className="time">
      <label label={time()} onDestroy={() => time.drop()} />
    </box>
  );
};
