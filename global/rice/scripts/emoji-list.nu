def main [wtype_path, emojis_path] {
  let emoji = bat $emojis_path | from json | transpose emoji descriptions | each {|o| $"($o.emoji) ($o.descriptions | str join ' ' | str replace -a '_' ' ')"} | str join "\n" | fuzzel -d | split chars | $in.0
  $emoji | wl-copy
  ^$wtype_path $emoji
}
