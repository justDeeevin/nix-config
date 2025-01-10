import { Variable } from "astal";

type Props = {
  month: Variable<number>;
  year: Variable<number>;
};
export default ({ month, year }: Props) => {
  const now = new Date();
  const days = Variable.derive([month(), year()], (month, year) => {
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
              return (
                <label
                  label={d.toString()}
                  css={`
                    ${d === now.getDate().toString() &&
                    month.get() - 1 === now.getMonth() &&
                    year.get() === now.getFullYear()
                      ? "color: #42be65"
                      : ""}
                  `}
                />
              );
            })}
          </box>
        )),
      )}
    </box>
  );
};
