// @ts-ignore
import { $ } from "bun";

const status = ((await $`wpctl status`.text()) as string).split("\n");

const audio_index = status.findIndex((line) => line === "Audio");
const video_index = status.findIndex((line) => line === "Video");

const audio = status.slice(audio_index + 1, video_index - 1);

const sinks_index = audio.findIndex((line) => line.match(/Sinks:$/));
const sources_index = audio.findIndex((line) => line.match(/Sources:$/));

const sinks_text = audio.slice(sinks_index + 1, sources_index - 1);

const regex =
  / │ *(?<selected>\*)? *(?<id>[0-9]*)\. (?<name>.*) \[vol: (?<volume>[0-1]\.[0-9]{2})(?<muted> MUTED)?]/;

const sinks = sinks_text
  .map((line) => regex.exec(line)?.groups)
  .map((protosink) => ({
    selected: protosink?.selected !== undefined,
    id: parseInt(protosink?.id.trim() ?? ""),
    name: protosink?.name.trim() ?? "",
    muted: protosink?.muted !== undefined,
    volume: parseFloat(protosink?.volume.trim() ?? ""),
  }));

const selection =
  (await $`echo ${sinks.map((sink) => sink.name).join("\n")} | fuzzel -d`.text()) as string;

if (selection !== "") {
  const id = sinks.find((sink) => sink.name === selection)?.id as number;
  await $`wpctl set-default ${id}`.quiet();
}
