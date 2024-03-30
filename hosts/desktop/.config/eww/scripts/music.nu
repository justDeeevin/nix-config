# Get status
def "main status" [] {
  loop {
    match (playerctl status) {
      "Playing" => {
        echo "󰏥"
      },
      _ => {
        echo "󰐌"
      }
    }
  }
}

# Get song
def "main song" [] {
  loop {
    let title = playerctl metadata xesam:title

    if $title == "" {
      echo "Offline"
    } else {
      echo $title
    }
  }
}

# Get artist
def "main artist" [] {
  loop {
    echo (playerctl metadata xesam:artist)
  }
}

# Get cover
def "main cover" [] {
  loop {
    let status = playerctl status

    if $status == "Playing" or $status == "Paused" {
      echo (playerctl metadata mpris:artUrl)
    } else {
      echo "img/music"
    }
  }
}

# Toggle status
def "main toggle" [] {
  playerctl play-pause
}

# Next
def "main next" [] {
  playerctl next
}

# Previous
def "main previous" [] {
  playerctl previous
}

def main [] {}
