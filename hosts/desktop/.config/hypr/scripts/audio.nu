def "main volup" [] {
  let vol = (getvol)
  echo $vol
  if $vol < 1.0 {
    wpctl set-volume @DEFAULT_SINK@ 5%+
  }
}

def getvol [] {
  echo ((wpctl get-volume @DEFAULT_SINK@ | parse --regex "Volume: ([0-9]*\\.[0-9]*)( \\[MUTED\\])?").capture0.0 | into float)
}

def "main getvol" [] {
  echo (getvol)
}

def main [] {}
