def sinks [] {
  let status = wpctl status | lines
  let audio_index = ($status | enumerate | find -r `^Audio$`).index.0
  let status = $status | drop nth ..$audio_index
  let video_index = ($status | enumerate | find -r `^Video$`).index.0
  let audio = $status | drop nth ($video_index - 1)..

  let sinks_index = ($audio | enumerate | find -r `Sinks:$`).index.0
  let audio = $audio | drop nth ..$sinks_index
  let sources_index = ($audio | enumerate | find -r `Sources:$`).index.0
  let sinks = $audio | drop nth ($sources_index - 1)..

  let sinks = $sinks | parse -r ` │ *(?<selected>\*)? *(?<id>[0-9]*)\. (?<name>.*) \[vol: (?<volume>[0-1]\.[0-9]{2})(?<muted> MUTED)?]`
  return ($sinks | each { |sink|
    mut newSink = $sink
    $newSink.selected = $sink.selected != ''
    $newSink.id = $sink.id | str trim | into int
    $newSink.name = $sink.name | str trim
    $newSink.muted = $sink.muted != ''
    $newSink.volume = $sink.volume | str trim | into float
    return $newSink
  })
}

def current [] {
  (sinks | where selected == true).0
}

def "main dmenu" [] {
  let selection = (sinks).name | str join "\n" | fuzzel -d
  match $selection {
    (current).name | "" => {},
    _  => {
      let id = (sinks | where name == $selection).0.id
      wpctl set-default $id
      ^kill -SIGRTMIN+1 (pgrep waybar)
    }
  }
}

def main [] {}
