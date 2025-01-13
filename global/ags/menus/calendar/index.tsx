import { App, Astal, Gtk } from "astal/gtk3";
import { Variable } from "astal";
import Month from "./Month";

const { START, CENTER, END, FILL } = Gtk.Align;

export default () => {
  const now = new Date();
  const month = Variable(now.getMonth() + 1);
  const year = Variable(now.getFullYear());
  const monthName = month().as((m) => {
    switch (m) {
      case 1:
        return "January";
      case 2:
        return "February";
      case 3:
        return "March";
      case 4:
        return "April";
      case 5:
        return "May";
      case 6:
        return "June";
      case 7:
        return "July";
      case 8:
        return "August";
      case 9:
        return "September";
      case 10:
        return "October";
      case 11:
        return "November";
      case 12:
        return "December";
    }
  });

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
        <box halign={FILL}>
          <button
            onClicked={() => year.set(year.get() - 1)}
            cursor="pointer"
            css="margin-right: 8px"
            hexpand
            halign={START}
          >
            {"<"}
          </button>
          <label label={year().as(String)} />
          <button
            onClicked={() => year.set(year.get() + 1)}
            cursor="pointer"
            css="margin-left: 8px"
            hexpand
            halign={END}
          >
            {">"}
          </button>
        </box>
        <box halign={FILL}>
          <button
            onClicked={() => {
              const m = month.get();
              if (m === 1) {
                month.set(12);
                year.set(year.get() - 1);
              } else month.set(m - 1);
            }}
            cursor="pointer"
            css="margin-right: 8px"
            hexpand
            halign={START}
          >
            {"<"}
          </button>
          <label label={monthName} />
          <button
            onClicked={() => {
              const m = month.get();
              if (m === 12) {
                month.set(1);
                year.set(year.get() + 1);
              } else month.set(m + 1);
            }}
            cursor="pointer"
            css="margin-left: 8px"
            hexpand
            halign={END}
          >
            {">"}
          </button>
        </box>
        <Month month={month} year={year} />
      </box>
    </window>
  );
};
