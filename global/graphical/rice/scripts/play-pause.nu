def main [playerctl?: path] {
    let playerctl = if $playerctl == null { "playerctl" } else { $playerctl }
    let firefox = ^$playerctl --list-all | find -n firefox | get -o 0
    let player = if $firefox != null and (^$playerctl --player $firefox status) == "Playing" { $firefox } else { "YoutubeMusic,%any" }
    ^$playerctl --player $player play-pause
}
