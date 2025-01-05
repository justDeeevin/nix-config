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
    const days = new Array<number[]>(7).fill([]);
    days.forEach((_, i) => (days[i] = new Array(5).fill(0)));

    days.forEach((w, oi) =>
      w.forEach((_, ii) => {
        const i = ii * 7 + oi - new Date(year, month - 1, 0).getDay();
        days[oi][ii] = new Date(year, month, i).getDate();
      }),
    );
    return days;
  });
  return (
    <box>
      {days().as((days) =>
        days.map((w) => (
          <box vertical>
            {w.map((d) => (
              <label
                label={d.toString()}
                css={m.as(
                  (month) => `
                  margin: 2px;
                  ${
                    d === now.getDate() &&
                    month - 1 === now.getMonth() &&
                    year === now.getFullYear()
                      ? "color: #42be65"
                      : ""
                  }
                `,
                )}
              />
            ))}
          </box>
        )),
      )}
    </box>
  );
};
