import { App, Astal, Gtk } from "astal/gtk3";
import { Variable } from "astal";
import Month from "./Month";

const { START, END, CENTER } = Gtk.Align;

export default () => {
  const now = new Date();
  const month = Variable(now.getMonth() + 1);
  const year = Variable(now.getFullYear());

  return (
    <window
      className="calendar"
      name="calendar"
      application={App}
      layer={Astal.Layer.TOP}
      anchor={Astal.WindowAnchor.TOP}
      visible={false}
    >
      <box vertical>
        <box hexpand halign={CENTER}>
          <button halign={START} onClicked={() => month.set(month.get() - 1)}>
            {"<"}
          </button>
          <button halign={END} onClicked={() => month.set(month.get() + 1)}>
            {">"}
          </button>
        </box>
        <Month month={month()} year={year()} />
      </box>
    </window>
  );
};
