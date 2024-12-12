def main [wtype_path] {
  let emoji = http get https://raw.githubusercontent.com/muan/emojilib/v4.0.0/dist/emoji-en-US.json | transpose emoji descriptions | each {|o| $"($o.emoji) ($o.descriptions | str join ' ' | str replace -a '_' ' ')"} | str join "\n" | fuzzel -d | split chars | $in.0
  $emoji | wl-copy
  ^$wtype_path $emoji
}
