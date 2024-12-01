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

  let sinks = $sinks | parse -r ` │ *(?<selected>\*)? *(?<id>[0-9]*)\. (?<name>.*) \[vol: 1\.00\]`
  let sinks = $sinks | each {|sink| mut newSink = $sink; $newSink.selected = $sink.selected != ''; return $newSink}
  let sinks = $sinks | each {|sink| mut newSink = $sink; $newSink.name = $sink.name | str trim; return $newSink}
  return $sinks
}

def current_name [] {
  (sinks | where selected == true).0.name
}

def "main tofi" [] {
  let selection = (sinks).name | str join "\n" | tofi
  match $selection {
    (current_name) => {},
    _ => {
      let id = (sinks | where name == $selection).0.id
      wpctl set-default $id
      ^kill -SIGRTMIN+1 (pgrep waybar)
    }
  }
}

def "main current" [] {
  print (current_name)
}

def main [] {}
