def main [window: string] {
  let monitor = (hyprctl activewindow -j | from json).monitor
  let file = $"($env.HOME)/.cache/eww_launch.($window)($monitor)"
  let exists = try {not (ls $file | is-empty)} catch {false}
  
  if $exists {
    eww close $"($window)($monitor)"
    rm $file
  } else {
    eww open $"($window)($monitor)"
    touch $file
  }
}
