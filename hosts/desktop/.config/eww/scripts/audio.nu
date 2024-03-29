# Listen for volume
def "main get-vol" [] {
  loop {
    echo (((wpctl get-volume @DEFAULT_SINK@ | parse --regex "Volume: ((?:1|0).[0-9]{2})").capture0.0 | into float) * 100)
    sleep 1sec
  }
}

# Set Volume
def "main set-vol" [vol: int] {
  wpctl set-volume @DEFAULT_SINK@ $"($vol)%"
}

# Toggle Volume
def "main toggle-vol" [] {
  wpctl set-mute @DEFAULT_SINK@ toggle
}

# Listen for volume icon
def "main get-volicon" [] {
  loop {
    let raw_caps = wpctl get-volume @DEFAULT_SINK@ | parse --regex "Volume: ((?:1|0)\\.[0-9]{2})( \\[MUTED\\])?"
    let vol = $raw_caps.capture0.0 | into float
    let muted = not ($raw_caps.capture1.0 | is-empty)
    if $vol == 0 or $muted {
      echo "󰝟"
    } else if $vol <= 0.30 {
      echo "󰕿"
    } else if $vol <= 0.60 {
      echo "󰖀"
    } else {
      echo "󰕾"
    }
    sleep 1sec
  }
}

# Listen for mic icon
def "main get-micicon" [] {
  loop {
    let raw_caps = wpctl get-volume @DEFAULT_SOURCE@ | parse --regex "Volume: ([0-9]{0,3}\\.[0-9]{2})( \\[MUTED\\])?"
    let vol = $raw_caps.capture0.0 | into float
    let muted = not ($raw_caps.capture1.0 | is-empty)
    if $vol == 0 or $muted {
     echo ""
    } else {
      echo ""
    }
    sleep 1sec
  }
}

# Toggle Mic
def "main toggle-mic" [] {
  wpctl set-mute @DEFAULT_SOURCE@ toggle
}

# Listen for mic volume
def "main get-mic" [] {
  loop {
    echo ((wpctl get-volume @DEFAULT_SOURCE@ | parse --regex "Volume: ([0-9]{0,3}\\.[0-9]{2})( \\[MUTED\\])?").capture0.0 | into int)
    sleep 1sec
  }
}

# Set Mic
def "main set-mic" [vol: int] {
  wpctl set-volume @DEFAULT_SOURCE@ $"($vol)%"
}

def main [] {}
