import { Binding, Variable } from "astal";

type Props = {
  month: number | Binding<number>;
  year: number | Binding<number>;
};
export default ({ month, year }: Props) => {
  const now = new Date();
  const m = month instanceof Binding ? month : Variable(month)();
  const y = year instanceof Binding ? year : Variable(year)();
  const days = Variable.derive([m, y], (month, year) => {
    const days = new Array<string[]>(7).fill([]);
    days.forEach((_, i) => (days[i] = new Array(6).fill("")));

    days.forEach((w, oi) =>
      w.forEach((_, ii) => {
        if (ii === 0) days[oi][ii] = oi.toString();
        else {
          const i = (ii - 1) * 7 + oi - new Date(year, month - 1, 0).getDay();
          days[oi][ii] = new Date(year, month - 1, i).getDate().toString();
        }
      }),
    );
    return days;
  });

  return (
    <box>
      {days().as((days) =>
        days.map((w, day) => (
          <box vertical css="margin: 2px">
            {w.map((d, i) => {
              if (i === 0) {
                return (
                  <label
                    css="font-weight: bold"
                    label={(() => {
                      switch (day) {
                        case 0:
                          return "Su";
                        case 1:
                          return "Mo";
                        case 2:
                          return "Tu";
                        case 3:
                          return "We";
                        case 4:
                          return "Th";
                        case 5:
                          return "Fr";
                        case 6:
                          return "Sa";
                      }
                    })()}
                  />
                );
              }
              // This derive isn't necessary for reactivity, but rather because `m` and `y` are bindings and not variables, so I can't use `get()` on them
              let css = Variable.derive(
                [m, y],
                (month, year) => `
                  ${
                    d === now.getDate().toString() &&
                    month - 1 === now.getMonth() &&
                    year === now.getFullYear()
                      ? "color: #42be65"
                      : ""
                  }
                `,
              );
              return <label label={d.toString()} css={css()} />;
            })}
          </box>
        )),
      )}
    </box>
  );
};
