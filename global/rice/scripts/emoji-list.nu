def main [wtype_path, emojis_path] {
  let selection = bat $emojis_path | from json | transpose emoji descriptions | each {|o| $"($o.emoji) ($o.descriptions | str join ' ' | str replace -a '_' ' ')"} | str join "\n" | fuzzel -d | split chars

  let first_space = ($selection | enumerate | find ' ').0.index

  let emoji = $selection | drop nth $first_space.. | str join ''

  $emoji | wl-copy
  ^$wtype_path $emoji
}
